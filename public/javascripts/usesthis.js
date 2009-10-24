$(document).ready(function(){
	if (typeof(slug) != 'undefined'){
		var edit_url = '/' + slug + '/edit/';
	
		$('a#publish').click(function(){
			if(!window.confirm('Publish this interview?')) {
				return false;
			}
		
			$.post(edit_url + 'published_at', { published_at: Date() }, function(result){
				$('p.unpublished').replaceWith("<time>" + result + "</time>");
			});
		
			return true;
		});
	
		$('h2.person').editable(edit_url + 'person', {
			cssclass: 'editor',
			name: 'person',
			id: '',
		});
	
		$('img.portrait + p').editable(edit_url + 'credits', {
			cssclass: 'editor',
			name: 'credits',
			id: '',
			loadurl: '/' + slug + '/credits',
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
	}
});