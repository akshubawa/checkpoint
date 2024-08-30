const mongoose = require('mongoose');

const offSiteWorkSchema = new mongoose.Schema({
  employee: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Employee',
    required: true
  },
  date: {
    type: Date,
    required: true
  },
  type: {
    type: String,
    enum: ['Offsite Tour', 'Office Work Visit', 'Sick Leave', 'Half Day', 'Work From Home','Early Checkout'],
    required: true
  },
  reason: {
    type: String,
    required: true
  },
  status: {
    type: String,
    enum: ['Pending', 'Approved', 'Rejected'],
    default: 'Pending'
  },
  approvedBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Employee'
  },
  comments: {
    type: String
  }
}, { timestamps: true });

module.exports = mongoose.model('OffSiteWork', offSiteWorkSchema);
