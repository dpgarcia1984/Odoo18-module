from odoo import models, fields, api

class AuditorEvaluation(models.Model):
    _name = 'auditor.evaluation'
    _description = 'Auditor Evaluation'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Evaluation Title', required=True)
    auditor_id = fields.Many2one('res.users', string='Auditor', domain=[('is_auditor', '=', True)])
    evaluator_id = fields.Many2one('res.users', string='Evaluator')
    evaluation_date = fields.Date('Evaluation Date', required=True)
    audit_id = fields.Many2one('audit.plan', string='Related Audit')
    
    # Evaluation Criteria
    technical_knowledge = fields.Selection([
        ('1', 'Poor'),
        ('2', 'Fair'),
        ('3', 'Good'),
        ('4', 'Very Good'),
        ('5', 'Excellent')
    ], string='Technical Knowledge', required=True)
    
    communication_skills = fields.Selection([
        ('1', 'Poor'),
        ('2', 'Fair'),
        ('3', 'Good'),
        ('4', 'Very Good'),
        ('5', 'Excellent')
    ], string='Communication Skills', required=True)
    
    professionalism = fields.Selection([
        ('1', 'Poor'),
        ('2', 'Fair'),
        ('3', 'Good'),
        ('4', 'Very Good'),
        ('5', 'Excellent')
    ], string='Professionalism', required=True)
    
    comments = fields.Text('Comments')
    recommendations = fields.Text('Recommendations')
    
    overall_rating = fields.Float('Overall Rating', compute='_compute_overall_rating', store=True)
    
    @api.depends('technical_knowledge', 'communication_skills', 'professionalism')
    def _compute_overall_rating(self):
        for record in self:
            scores = [
                float(record.technical_knowledge or 0),
                float(record.communication_skills or 0),
                float(record.professionalism or 0)
            ]
            record.overall_rating = sum(scores) / len(scores) if scores else 0.0