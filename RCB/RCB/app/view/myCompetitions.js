Ext.define('BR.view.myCompetitions' ,{
    extend: 'Ext.panel.Panel',
    alias : 'widget.myCompetitions',
    border: 0,
    bodyPadding: '10',
    autoScroll: true,
    region: 'center',
    layout:'card',
    activeItem: 0,
    items: [{
	    id: 'card-0',
            border: false,
            bodyPadding: '10',
	        html: '<h1>'+BR.lang.comp.mess+'</h1>'
	},{
	    id: 'card-1',
            border: true,
	    xtype: 'myEventsDetails'
	}]
});


