$(document).ready(function(){
	var edit_url = '/' + slug + '/edit/';
	
	$('h2.person').editable(edit_url + 'person', {
		cssclass: 'editor',
		name: 'person',
		id: '',
	});
	
	$('img.portrait + p').editable(edit_url + 'credits', {
		cssclass: 'editor',
		name: 'credits',
		id: '',
	});
	
	$('p.summary').editable(edit_url + 'summary', {
		cssclass: 'editor',
		name: 'summary',
		id: '',
	});
	
	$('article.contents').editable(edit_url + 'contents', {
		cssclass: 'editor',
		name: 'contents',
		id: '',
		loadurl: '/' + slug + '/contents',
		type: 'textarea',
		submit: 'OK',
	});	
});