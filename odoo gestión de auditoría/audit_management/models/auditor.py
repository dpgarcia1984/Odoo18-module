from odoo import models, fields, api

class Auditor(models.Model):
    _inherit = 'res.users'

    is_auditor = fields.Boolean('Is Auditor')
    auditor_level = fields.Selection([
        ('trainee', 'Trainee'),
        ('junior', 'Junior'),
        ('senior', 'Senior'),
        ('lead', 'Lead Auditor')
    ], string='Auditor Level')
    certification_ids = fields.One2many('auditor.certification', 'auditor_id', string='Certifications')
    specialization = fields.Many2many('audit.area', string='Specialization Areas')
    experience_years = fields.Float('Years of Experience')
    audit_count = fields.Integer('Number of Audits', compute='_compute_audit_count')

    @api.depends('audit_ids')
    def _compute_audit_count(self):
        for record in self:
            record.audit_count = len(record.audit_ids)