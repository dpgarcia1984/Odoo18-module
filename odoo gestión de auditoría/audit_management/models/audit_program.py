from odoo import models, fields, api
from datetime import datetime

class AuditProgram(models.Model):
    _name = 'audit.program'
    _description = 'Audit Program'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Program Name', required=True, tracking=True)
    code = fields.Char('Program Code', required=True, readonly=True, default='New')
    year = fields.Integer('Year', required=True, default=lambda self: datetime.now().year)
    start_date = fields.Date('Start Date', required=True)
    end_date = fields.Date('End Date', required=True)
    objective = fields.Text('Objective', required=True)
    scope = fields.Text('Scope', required=True)
    state = fields.Selection([
        ('draft', 'Draft'),
        ('approved', 'Approved'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled')
    ], string='Status', default='draft', tracking=True)
    responsible_id = fields.Many2one('res.users', string='Responsible', required=True)
    planned_audits = fields.One2many('audit.plan', 'program_id', string='Planned Audits')
    
    @api.model
    def create(self, vals):
        if vals.get('code', 'New') == 'New':
            vals['code'] = self.env['ir.sequence'].next_by_code('audit.program') or 'New'
        return super(AuditProgram, self).create(vals)

    def action_approve(self):
        self.write({'state': 'approved'})

    def action_start(self):
        self.write({'state': 'in_progress'})

    def action_complete(self):
        self.write({'state': 'completed'})

    def action_cancel(self):
        self.write({'state': 'cancelled'})