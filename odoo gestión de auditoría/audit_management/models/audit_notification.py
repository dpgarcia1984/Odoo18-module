from odoo import models, fields, api

class AuditNotification(models.Model):
    _name = 'audit.notification'
    _description = 'Audit Notification'
    _inherit = ['mail.thread', 'mail.activity.mixin']

    name = fields.Char('Notification Title', required=True)
    notification_date = fields.Date('Notification Date', required=True)
    audit_plan_id = fields.Many2one('audit.plan', string='Audit Plan', required=True)
    recipient_ids = fields.Many2many('res.users', string='Recipients')
    description = fields.Text('Description')
    state = fields.Selection([
        ('draft', 'Draft'),
        ('sent', 'Sent'),
        ('confirmed', 'Confirmed'),
        ('cancelled', 'Cancelled')
    ], string='Status', default='draft', tracking=True)

    def action_send_notification(self):
        # Logic to send email notifications
        self.write({'state': 'sent'})

    def action_confirm(self):
        self.write({'state': 'confirmed'})

    def action_cancel(self):
        self.write({'state': 'cancelled'})