from odoo import models, fields, api

class ActionPlan(models.Model):
    _name = 'audit.action.plan'
    _description = 'Action Plan'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Action Title', required=True)
    nonconformity_id = fields.Many2one('audit.nonconformity', string='Non-Conformity')
    description = fields.Text('Description', required=True)
    responsible_id = fields.Many2one('res.users', string='Responsible')
    start_date = fields.Date('Start Date')
    end_date = fields.Date('End Date')
    resources = fields.Text('Required Resources')
    progress = fields.Float('Progress (%)', default=0.0)
    state = fields.Selection([
        ('draft', 'Draft'),
        ('approved', 'Approved'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled')
    ], string='Status', default='draft', tracking=True)