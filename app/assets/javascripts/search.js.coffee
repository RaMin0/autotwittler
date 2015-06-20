$('[rel=typeahead]').each (_, elm) ->
  elm = $(elm)
  
  elm
    .typeahead
      classNames:
        menu: 'list-group'
        suggestion: 'list-group-item'
        cursor: 'active'
    ,
      source: new Bloodhound
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
        queryTokenizer: Bloodhound.tokenizers.whitespace
        remote:
          url: decodeURI(elm.data('remote-url'))
          wildcard: '%QUERY'
      display: 'name'
      templates:
        suggestion: doT.template """
          <a href="{{= it.url}}" class="media">
            <div class="media-left media-middle">
              <img width="73" class="media-object img-circle img-thumbnail" src="{{= it.profile_image_url}}" />
            </div>
            <div class="media-body">
              <h4>{{= it.name}}</h4>
              <p>@{{= it.screen_name}}</p>
            </div>
          </a>
        """
    .on 'typeahead:select', (e, data) -> location.href = data.url
    .on 'typeahead:asyncrequest', ->
        $('.navbar-form .input-group-addon i')
          .filter('.fa-search').addClass('hide').end()
          .filter('.fa-refresh').removeClass('hide').end()
    .on 'typeahead:asynccancel, typeahead:asyncreceive', ->
        $('.navbar-form .input-group-addon i')
          .filter('.fa-search').removeClass('hide').end()
          .filter('.fa-refresh').addClass('hide').end()
