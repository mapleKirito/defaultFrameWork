/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Toolbar configuration generated automatically by the editor based on config.toolbarGroups.
	config.toolbar = [
	    { name: 'insert', items: [ 'Image' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
		{ name: 'styles', items: [ 'FontSize' ] },
		{ name: 'tools', items: [ 'Maximize' ] }
	];
	config.removeDialogTabs = 'image:advanced';
	
};
