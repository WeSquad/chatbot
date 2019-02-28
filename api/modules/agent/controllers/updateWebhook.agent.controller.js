'use strict';
const Async = require('async');
const Boom = require('boom');
const Flat = require('../../../helpers/flat');
const Cast = require('../../../helpers/cast');
const RemoveBlankArray = require('../../../helpers/removeBlankArray');

const updateDataFunction = (redis, agentId, currentWebhook, updateData, cb) => {

    if (updateData.slots){
        currentWebhook.slots = updateData.slots;
    }
    if (updateData.agentResponses){
        currentWebhook.agentResponses = updateData.agentResponses;
    }
    const flatWebhook = Flat(currentWebhook);
    const flatUpdateData = Flat(updateData);
    Object.keys(flatUpdateData).forEach( (key) => {

        flatWebhook[key] = flatUpdateData[key];
    });
    redis.del(`agentWebhook:${agentId}`, (err) => {

        if (err){
            const error = Boom.badImplementation('An error occurred temporaly removing the webhook for the update.');
            return cb(error);
        }
        redis.hmset(`agentWebhook:${agentId}`, RemoveBlankArray(flatWebhook), (err) => {

            if (err){
                const error = Boom.badImplementation('An error occurred adding the webhook data.');
                return cb(error);
            }
            return cb(null, Flat.unflatten(flatWebhook));
        });
    });
};

module.exports = (request, reply) => {

    const agentId = request.params.id;
    const updateData = request.payload;

    const server = request.server;
    const redis = server.app.redis;

    Async.waterfall([
        (cb) => {

            server.inject(`/agent/${agentId}/webhook`, (res) => {

                if (res.statusCode !== 200){
                    if (res.statusCode === 404){
                        const error = Boom.notFound('The specified webhook doesn\'t exists');
                        return cb(error, null);
                    }
                    const error = Boom.create(res.statusCode, `An error occurred getting the data of the webhook ${agentId}`);
                    return cb(error, null);
                }
                return cb(null, res.result);
            });
        },
        (currentWebhook, cb) => {

            updateDataFunction(redis, agentId, currentWebhook, updateData, (err, result) => {

                if (err){
                    const error = Boom.badImplementation('An error occurred adding the webhook data.');
                    return cb(error);
                }
                return cb(null, result);
            });
        }
    ], (err, result) => {

        if (err){
            return reply(err, null);
        }
        return reply(Cast(result, 'webhook'));
    });
};
