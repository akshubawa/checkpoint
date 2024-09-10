//joi
const Joi = require("joi");

module.exports.createOfficeSchema = Joi.object({
  office: Joi.object({
    name: Joi.string().required(),
    address: Joi.string().required(),
    city: Joi.string().required(),
    state: Joi.string().required(),
    country: Joi.string().required(),
    zipCode: Joi.string().required(),
    coordinates: Joi.object({
      latitude: Joi.number().required(),
      longitude: Joi.number().required(),
    }).required(),
    radius: Joi.number().required(),
  }).required(),
});
