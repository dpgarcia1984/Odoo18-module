from odoo import models, fields, api

class AuditFinding(models.Model):
    _name = 'audit.finding'
    _description = 'Audit Finding'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Finding Title', required=True)
    code = fields.Char('Finding Code', required=True, readonly=True, default='New')
    audit_plan_id = fields.Many2one('audit.plan', string='Audit Plan', required=True)
    finding_date = fields.Date('Finding Date', required=True)
    type = fields.Selection([
        ('nonconformity', 'Non-Conformity'),
        ('observation', 'Observation'),
        ('opportunity', 'Improvement Opportunity')
    ], string='Finding Type', required=True)
    description = fields.Text('Description', required=True)
    evidence = fields.Text('Evidence')
    severity = fields.Selection([
        ('low', 'Low'),
        ('medium', 'Medium'),
        ('high', 'High'),
        ('critical', 'Critical')
    ], string='Severity', required=True)
    state = fields.Selection([
        ('draft', 'Draft'),
        ('confirmed', 'Confirmed'),
        ('action_required', 'Action Required'),
        ('in_progress', 'In Progress'),
        ('closed', 'Closed')
    ], string='Status', default='draft', tracking=True)

    @api.model
    def create(self, vals):
        if vals.get('code', 'New') == 'New':
            vals['code'] = self.env['ir.sequence'].next_by_code('audit.finding') or 'New'
        return super(AuditFinding, self).create(vals)