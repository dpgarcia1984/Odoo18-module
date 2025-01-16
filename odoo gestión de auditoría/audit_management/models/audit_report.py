from odoo import models, fields, api

class AuditReport(models.Model):
    _name = 'audit.report'
    _description = 'Audit Report'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Report Title', required=True)
    audit_plan_id = fields.Many2one('audit.plan', string='Audit Plan', required=True)
    report_date = fields.Date('Report Date', required=True)
    executive_summary = fields.Text('Executive Summary', required=True)
    methodology = fields.Text('Methodology')
    findings_ids = fields.One2many('audit.finding', 'audit_report_id', string='Findings')
    conclusion = fields.Text('Conclusion')
    recommendations = fields.Text('Recommendations')
    state = fields.Selection([
        ('draft', 'Draft'),
        ('review', 'In Review'),
        ('approved', 'Approved'),
        ('published', 'Published')
    ], string='Status', default='draft', tracking=True)
    
    def action_submit_review(self):
        self.write({'state': 'review'})

    def action_approve(self):
        self.write({'state': 'approved'})

    def action_publish(self):
        self.write({'state': 'published'})