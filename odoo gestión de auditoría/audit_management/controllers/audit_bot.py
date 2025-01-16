from odoo import http
from odoo.http import request
import openai
import json

class AuditBot(http.Controller):
    @http.route('/audit/bot/assist', type='json', auth='user')
    def get_bot_assistance(self, query):
        try:
            # Configure OpenAI
            openai.api_key = request.env['ir.config_parameter'].sudo().get_param('audit.openai_api_key')
            
            # Create context from audit data
            audit_context = self._get_audit_context()
            
            # Prepare the prompt
            prompt = f"""
            Context: {audit_context}
            User Query: {query}
            Please provide assistance regarding the audit management system.
            """
            
            # Get response from OpenAI
            response = openai.ChatCompletion.create(
                model="gpt-4",
                messages=[
                    {"role": "system", "content": "You are an expert audit management assistant."},
                    {"role": "user", "content": prompt}
                ]
            )
            
            return {
                'status': 'success',
                'response': response.choices[0].message.content
            }
            
        except Exception as e:
            return {
                'status': 'error',
                'message': str(e)
            }
    
    def _get_audit_context(self):
        # Get relevant audit information from the database
        env = request.env
        
        context = {
            'active_audits': env['audit.plan'].search_count([('state', '=', 'in_progress')]),
            'pending_findings': env['audit.finding'].search_count([('state', '!=', 'closed')]),
            'recent_notifications': env['audit.notification'].search_count([('create_date', '>=', fields.Date.today())])
        }
        
        return json.dumps(context)