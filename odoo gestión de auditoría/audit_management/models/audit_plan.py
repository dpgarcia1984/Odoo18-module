from odoo import models, fields, api

class AuditPlan(models.Model):
    _name = 'audit.plan'
    _description = 'Audit Plan'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Plan Name', required=True)
    program_id = fields.Many2one('audit.program', string='Audit Program', required=True)
    planned_date = fields.Date('Planned Date', required=True)
    duration = fields.Float('Duration (Days)', required=True)
    auditor_ids = fields.Many2many('res.users', string='Auditors', domain=[('is_auditor', '=', True)])
    auditee_ids = fields.Many2many('res.users', string='Auditees')
    objective = fields.Text('Objective', required=True)
    scope = fields.Text('Scope', required=True)
    methodology = fields.Text('Methodology')
    state = fields.Selection([
        ('draft', 'Draft'),
        ('planned', 'Planned'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled')
    ], string='Status', default='draft', tracking=True)
    
    def action_plan(self):
        self.write({'state': 'planned'})

    def action_start(self):
        self.write({'state': 'in_progress'})

    def action_complete(self):
        self.write({'state': 'completed'})

    def action_cancel(self):
        self.write({'state': 'cancelled'})