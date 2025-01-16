from odoo import models, fields, api

class Nonconformity(models.Model):
    _name = 'audit.nonconformity'
    _description = 'Non-Conformity'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Title', required=True)
    finding_id = fields.Many2one('audit.finding', string='Related Finding')
    description = fields.Text('Description', required=True)
    root_cause = fields.Text('Root Cause Analysis')
    correction = fields.Text('Immediate Correction')
    corrective_action = fields.Text('Corrective Action')
    responsible_id = fields.Many2one('res.users', string='Responsible')
    deadline = fields.Date('Deadline')
    state = fields.Selection([
        ('draft', 'Draft'),
        ('analysis', 'Under Analysis'),
        ('action', 'Action Required'),
        ('verification', 'In Verification'),
        ('closed', 'Closed')
    ], string='Status', default='draft', tracking=True)