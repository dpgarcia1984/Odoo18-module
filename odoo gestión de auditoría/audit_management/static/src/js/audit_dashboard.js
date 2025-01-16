odoo.define('audit_management.Dashboard', function (require) {
    "use strict";

    var AbstractAction = require('web.AbstractAction');
    var core = require('web.core');
    var QWeb = core.qweb;
    var rpc = require('web.rpc');
    var ajax = require('web.ajax');

    var AuditDashboard = AbstractAction.extend({
        template: 'audit_management.Dashboard',
        events: {
            'click .refresh-dashboard': '_onRefresh',
        },

        init: function(parent, action) {
            this._super.apply(this, arguments);
            this.dashboardData = {};
            this.charts = {};
        },

        willStart: function() {
            return Promise.all([
                this._super.apply(this, arguments),
                this._loadDashboardData()
            ]);
        },

        start: function() {
            return this._super.apply(this, arguments).then(() => {
                this._renderCharts();
            });
        },

        _loadDashboardData: function() {
            return rpc.query({
                model: 'audit.dashboard',
                method: 'get_audit_kpis',
                args: [],
            }).then(data => {
                this.dashboardData = data;
            });
        },

        _renderCharts: function() {
            this._renderAuditTrend();
            this._renderFindingsByType();
            this._renderAuditEffectiveness();
        },

        _renderAuditTrend: function() {
            rpc.query({
                model: 'audit.dashboard',
                method: 'get_audit_trend_data',
                args: [],
            }).then(data => {
                const ctx = this.$('.audit-trend-chart')[0].getContext('2d');
                this.charts.auditTrend = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: data.map(d => moment(d.month).format('MMM YYYY')),
                        datasets: [{
                            label: 'Audits',
                            data: data.map(d => d.audit_count),
                            borderColor: '#7C7BAD',
                            tension: 0.1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false
                    }
                });
            });
        },

        _renderFindingsByType: function() {
            rpc.query({
                model: 'audit.dashboard',
                method: 'get_finding_by_type',
                args: [],
            }).then(data => {
                const ctx = this.$('.findings-by-type-chart')[0].getContext('2d');
                this.charts.findingsByType = new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: data.map(d => d.type),
                        datasets: [{
                            data: data.map(d => d.count),
                            backgroundColor: [
                                '#FF6384',
                                '#36A2EB',
                                '#FFCE56'
                            ]
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false
                    }
                });
            });
        },

        _renderAuditEffectiveness: function() {
            const ctx = this.$('.audit-effectiveness-chart')[0].getContext('2d');
            const effectiveness = this.dashboardData.audit_effectiveness;
            
            this.charts.auditEffectiveness = new Chart(ctx, {
                type: 'gauge',
                data: {
                    datasets: [{
                        value: effectiveness,
                        minValue: 0,
                        maxValue: 100,
                        backgroundColor: [
                            '#FF6384',
                            '#36A2EB',
                            '#4BC0C0'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        },

        _onRefresh: function() {
            this._loadDashboardData().then(() => {
                this._renderCharts();
            });
        },
    });

    core.action_registry.add('audit_dashboard', AuditDashboard);

    return AuditDashboard;
});