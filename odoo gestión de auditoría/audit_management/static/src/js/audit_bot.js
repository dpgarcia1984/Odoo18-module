odoo.define('audit_management.AuditBot', function (require) {
    "use strict";

    var Widget = require('web.Widget');
    var core = require('web.core');
    var _t = core._t;

    var AuditBot = Widget.extend({
        template: 'audit_management.AuditBotWidget',
        events: {
            'click .audit-bot-toggle': '_toggleBot',
            'click .send-query': '_sendQuery',
            'keypress .query-input': '_onKeypress',
        },

        init: function (parent) {
            this._super.apply(this, arguments);
            this.isOpen = false;
        },

        _toggleBot: function () {
            this.isOpen = !this.isOpen;
            this.$('.audit-bot-container').toggleClass('open', this.isOpen);
        },

        _sendQuery: function () {
            var self = this;
            var query = this.$('.query-input').val();
            
            if (!query) return;

            this._showLoading();
            
            this._rpc({
                route: '/audit/bot/assist',
                params: {
                    query: query,
                },
            }).then(function (result) {
                if (result.status === 'success') {
                    self._appendMessage(result.response, 'bot');
                } else {
                    self._appendMessage(_t("Sorry, I couldn't process your request."), 'bot');
                }
            }).finally(function () {
                self._hideLoading();
                self.$('.query-input').val('');
            });
        },

        _onKeypress: function (ev) {
            if (ev.which === 13) {
                this._sendQuery();
            }
        },

        _appendMessage: function (message, type) {
            var messageHtml = `<div class="message ${type}-message">
                <div class="message-content">${message}</div>
            </div>`;
            this.$('.chat-messages').append(messageHtml);
            this._scrollToBottom();
        },

        _scrollToBottom: function () {
            var chatMessages = this.$('.chat-messages');
            chatMessages.scrollTop(chatMessages[0].scrollHeight);
        },

        _showLoading: function () {
            this.$('.bot-loading').removeClass('d-none');
        },

        _hideLoading: function () {
            this.$('.bot-loading').addClass('d-none');
        },
    });

    core.action_registry.add('audit_bot', AuditBot);

    return AuditBot;
});