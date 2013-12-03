Ext.define('BR.view.ContentArea' ,{
    extend: 'Ext.panel.Panel',
    alias: 'widget.contentArea',
    requires: ['BR.view.myEventsTree','BR.view.myEventsDetails','BR.view.myCompetitions'],
    layout: 'border',
    border: true,
    padding: '140 15 30 15',
    items: [{
        border: false,
	    region: 'north',
	    defaults :{
	        layout: 'fit',
	        height: '95',
	        bodyBorder: 0
	    }
    },{
        xtype: 'myEventsTree'
    },{
        xtype: 'myCompetitions'
    }]
});

