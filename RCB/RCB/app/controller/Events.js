/* Controller that handles almost everything */
Ext.define('BR.controller.Events', {
    extend: 'Ext.app.Controller',

    views: ['myEventsTree', 'myEventsDetails', 'myCompetitions', 'events.menu', 
            'events.add', 'competitions.add', 'competitions.menu', 'competitions.import','competitions.importFinal'],   

    stores: ['Comps'],

    refs: [{ ref: 'myEventsTree', selector: 'myEventsTree' },
           { ref: 'menuEvents', selector: 'menuEvents', autoCreate: true, xtype: 'menuEvents'},
           { ref: 'menuComps', selector: 'menuComps', autoCreate: true, xtype: 'menuComps'},
           { ref: 'myEventsDetails', selector: 'myEventsDetails' },
           { ref: 'myCompetitions', selector: 'myCompetitions' },
           { ref: 'addEvent', selector: 'addEvent', autoCreate: true, xtype: 'addEvent' },
           { ref: 'addEventForm', selector: 'addEvent form'},
           { ref: 'addCompForm', selector: 'addComp form'},
           { ref: 'importComp', selector: 'importComp', autoCreate: true, xtype: 'importComp' },
           { ref: 'importCompFinal', selector: 'importCompFinal', autoCreate: true, xtype: 'importCompFinal' },
           { ref: 'addComp', selector: 'addComp', autoCreate: true, xtype: 'addComp' }], 

    init: function() {
        var me = this;
        this.control({
            'myEventsTree button[action=add]': {
                click: this.addEvent
            },
            'myEventsTree button[action=edit]': {
                click: this.addEvent
            },
            'menuEvents menuitem[action=edit]' : {
                click: this.addEvent
            },
            'myEventsTree button[action=delete]': {
                click: this.deleteEvent
            },
            'menuEvents menuitem[action=delete]' : {
                click: this.deleteEvent
            },
            'myCompetitions button[action=add]': {
                click: this.addComp
            },
            'myCompetitions button[action=edit]': {
                click: this.addComp
            },
            'menuComps menuitem[action=edit]': {
                click: this.addComp
            },
            'myCompetitions button[action=delete]': {
                click: this.deleteComp
            },
            'menuComps menuitem[action=delete]' : {
                click: this.deleteComp
            },
            'myCompetitions button[action=import]': {
                click: this.importComp
            },
            'menuComps menuitem[action=import]' : {
                click: this.importComp
            },
            'myCompetitions button[action=importFinal]': {
                click: this.importCompFinal
            },
            'menuComps menuitem[action=importFinal]' : {
                click: this.importCompFinal
            },
            'myCompetitions button[action=view]': {
                click: this.viewComp
            },
            'menuComps menuitem[action=view]' : {
                click: this.viewComp
            },
            'addEvent button[action=validate]': {
                click: this.validateEvent
            },
            'addComp button[action=validate]': {
                click: this.validateComp
            },
            'importComp button[action=validate]': {
                click: this.validateImport
            },
            'importCompFinal button[action=validate]': {
                click: this.validateImportFinal
            },
            'myEventsTree': {
                selectionchange: this.watchSelections,
                itemcontextmenu: this.showContextMenu
            },
            'myEventsDetails': {
                selectionchange: this.watchGridSelections,
                itemcontextmenu: this.showGridContextMenu
            }

        });
    },

    addEvent: function( button ) {
        var win  = this.getAddEvent();
        var form = this.getAddEventForm();
        var tree  = this.getMyEventsTree();
        if( button.action == 'edit' ) {
            var selections = tree.getSelectionModel().getSelection();
            form.getForm().loadRecord(selections[0]);
            win.title = BR.lang.event.modTitle;
            form.down( 'field[name=form-action]' ).setValue(button.action);
            form.down( 'field[name=eid]' ).setValue(selections[0].get('id'));
        } else {
            win.title = BR.lang.event.addTitle;
        }
        win.show();
    },

    addComp: function( button ) {
        var win   = this.getAddComp();
        var form  = this.getAddCompForm();
        var grid  = this.getMyEventsDetails();
        if( button.action == 'edit' ) {
            var selections = grid.getSelectionModel().getSelection();
            form.getForm().loadRecord(selections[0]);
            win.title = BR.lang.event.modTitle;
            form.down( 'field[name=form-action]' ).setValue(button.action);
            form.down( 'field[name=cid]' ).setValue(selections[0].get('id'));
        } else {
            win.title = BR.lang.comp.addTitle;
        }
        win.show();
    },

    viewComp: function( button ) {
        var grid  = this.getMyEventsDetails();
        var selections = grid.getSelectionModel().getSelection();
        window.open( "services/view.aspx?cid=" + selections[0].get('id') );
    },

    validateEvent: function() {
        var tree  = this.getMyEventsTree();
        var panel = this.getMyCompetitions();
        var win   = this.getAddEvent();
        var form  = win.down('form');
        if( form.getForm().isValid() ) {
            tree.getEl().mask( BR.lang.loading );
            Ext.Ajax.request({
			    url: 'services/events.aspx?action=add',
			    params: form.getValues(),
			    success: function(response) {
				var result = Ext.decode(response.responseText);
				if( result.success == true ) {
                                    win.close();
                                    tree.store.load();
                                    tree.getEl().unmask();

				   // Show empty right panel
                                   if( panel.getHeader() ) {
                                       panel.getHeader().hide();
                                   }
				   panel.getLayout().setActiveItem(0);
				}
			    }
			});

        }
    },

    validateComp: function() {
        var tree  = this.getMyEventsTree();
        var selections = tree.getSelectionModel().getSelection();
        var grid = this.getMyEventsDetails();
        var panel = this.getMyCompetitions();
        var win   = this.getAddComp();
        var form  = win.down('form');
        if( form.getForm().isValid() ) {
           // tree.getEl().mask("chargement...");
          //  panel.getLayout().getEl().mask("chargement...");
            Ext.Ajax.request({
			    url: 'services/competitions.aspx?action=add&eid=' + selections[0].get('id'),
			    params: form.getValues(),
			    success: function(response) {
				var result = Ext.decode(response.responseText);
				if( result.success == true ) {
                                    win.close();

                                           
        grid.store.load({
	   params:{eid: selections[0].get('id')}
	});
				}
			    }
			});

        }
    },


    validateImport: function() {

        var grid = this.getMyEventsDetails();
        var selections = grid.getSelectionModel().getSelection();
        var win   = this.getImportComp();
        var form  = win.down('form');
        if( form.getForm().isValid() ) {

            Ext.Ajax.request({
			    url: 'services/import.aspx?cid=' + selections[0].get('id'),
			    params: {
                   // csv: form.getValues().csv.replace( /\"\n\"/g, "#####" ),
csv: form.getValues().csv.replace( /\"\r?\n\"/g, "#####" ),
                    date: Ext.Date.format(new Date(), 'Y-m-d H:i')
                },
			    success: function(response) {
				var result = Ext.decode(response.responseText);
				if( result.success == true ) {
                        win.close();
                        grid.store.reload();
                        grid.unmask();
				}
			    }
			});

        }
    },

    validateImportFinal: function() {

        var grid = this.getMyEventsDetails();
        var selections = grid.getSelectionModel().getSelection();
        var win   = this.getImportCompFinal();
        var form  = win.down('form');
        if( form.getForm().isValid() ) {

            Ext.Ajax.request({
			    url: 'services/import-final.aspx?cid=' + selections[0].get('id'),
			    params: {
                   // csv: form.getValues().csv.replace( /\"\n\"/g, "#####" ),
                   //csv: form.getValues().csv.replace( /\"\r?\n\"/g, "#####" ),
                    finalHtml: form.getValues().finalHtml,
                    date: Ext.Date.format(new Date(), 'Y-m-d H:i')
                },
			    success: function(response) {
				var result = Ext.decode(response.responseText);
				if( result.success == true ) {
                        win.close();
                        grid.store.reload();
                        grid.unmask();
				}
			    }
			});

        }
    },

    deleteEvent: function() {
        var tree = this.getMyEventsTree();
        var panel = this.getMyCompetitions();
        var selections = tree.getSelectionModel().getSelection();

        Ext.MessageBox.confirm( BR.lang.event.delTitle,
        BR.lang.event.delMsg1 + " <b>" + selections[0].get('name-fr') + '</b> ' + BR.lang.event.delMsg2,
        function( btn ){
            if( btn == "yes" ){
                tree.getEl().mask( BR.lang.loading );
		Ext.Ajax.request({
			    url: 'services/events.aspx',
			    params: {
                    eid: selections[0].get('id'),
				    action: "delete"
			    },
			    success: function(response) {
				var result = Ext.decode(response.responseText);
				if( result.success == true ) {
                                   tree.store.load();
                                   tree.getEl().unmask();

				   // Show empty right panel
                                   if( panel.getHeader() ) {
                                       panel.getHeader().hide();
                                   }
				   panel.getLayout().setActiveItem(0);
				}
			    }
			});
            }
        });

    },

    deleteComp: function() {
        var grid = this.getMyEventsDetails();
        var selections = grid.getSelectionModel().getSelection();

        Ext.MessageBox.confirm( BR.lang.comp.delTitle,
         BR.lang.comp.delMsg1 + " <b>" + selections[0].get('title-fr') + '</b> ' + BR.lang.event.delMsg1,
        function( btn ){
            if( btn == "yes" ){
                grid.getEl().mask( BR.lang.loading );
		Ext.Ajax.request({
			    url: 'services/competitions.aspx',
			    params: {
                    cid: selections[0].get('id'),
				    action: "delete"
			    },
			    success: function(response) {
				var result = Ext.decode(response.responseText);
				if( result.success == true ) {
                        grid.store.reload();
                        grid.unmask();
				}
			    }
			});
            }
        });

    },

    importComp: function( button ) {
        var win   = this.getImportComp();
        win.show();
    },

    importCompFinal: function( button ) {
        var win   = this.getImportCompFinal();
        win.show();
    },

    /**
     * Watch click on channel admin and show/hide appropriate button
     */
    watchSelections: function( sm, rs ) {

        // Activate delete button if a selection is made
        var tree = this.getMyEventsTree();
        tree.down( 'button[action=delete]' ).setDisabled( sm.getCount() < 1 );
        tree.down( 'button[action=edit]' ).setDisabled( sm.getCount() < 1 );
        var selections = tree.getSelectionModel().getSelection();

        // Show panel with competitions
        var panel = this.getMyCompetitions();
        if( panel.getHeader() ) {
            panel.getHeader().show();
        }
        panel.getLayout().setActiveItem(1);
        panel.setTitle( selections[0].get('name-fr') + ' - ' + BR.lang.comp.panelTitle );

        var grid = this.getMyEventsDetails();
        grid.store.load({
	        params:{eid: selections[0].get('id')}
	    });
    
    },

    /**
     * Show contextual menu
     */
    showContextMenu: function( row, r, a, y, e ) {
        e.stopEvent();
        var menu = this.getMenuEvents();
        menu.showAt(e.getXY());
    },

    /**
     * Watch click on channel admin and show/hide appropriate button
     */
    watchGridSelections: function( sm, rs ) {

        // Activate delete button if a selection is made
        var grid = this.getMyEventsDetails();
        grid.down( 'button[action=delete]' ).setDisabled( sm.getCount() < 1 );
        grid.down( 'button[action=edit]' ).setDisabled( sm.getCount() < 1 );
        grid.down( 'button[action=import]' ).setDisabled( sm.getCount() < 1 );
        grid.down( 'button[action=importFinal]' ).setDisabled( sm.getCount() < 1 );

        var selections = grid.getSelectionModel().getSelection();
        if( selections[0] ) {
            if( selections[0].get('lastDate') != "" ) {
                grid.down( 'button[action=view]' ).setDisabled( false );
            } else {
                grid.down( 'button[action=view]' ).setDisabled( true );
            }
        }
    },

    /**
     * Show contextual menu
     */
    showGridContextMenu: function( row, r, a, y, e ) {
        e.stopEvent();
        var menu = this.getMenuComps();
        var grid = this.getMyEventsDetails();
        var selections = grid.getSelectionModel().getSelection();
        if( selections[0] ) {
            if( selections[0].get('lastDate') != "" ) {
                menu.down( 'menuitem[action=view]' ).show();
            } else {
                menu.down( 'menuitem[action=view]' ).hide();
            }
        }
        menu.showAt(e.getXY());
    }


});
