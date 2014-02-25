# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class PropertiesEditor
  constructor: (@$el) ->
    @$list = @$el.find('table tbody').first()
    @template = @$el.data('template')

    @_bindRemove()
    @_bindAdd()
    @_bindUpdate()

  _bindRemove: ->
    @$el.on 'click', '.remove-property', ->
      $(this).closest('.property').remove()
      false

  _bindAdd: ->
    self = this
    @$el.on 'click', '.add-property', ->
      buffer =
        """
        <tr class="property">
          <td><input class="property-name" type="text" value=""></td>
          <td><input name="" type="text" value=""></td>
          <td><a href="#" class="remove-property">Remove</a></td>
        </tr>
        """
      self.$list.append(buffer)
      false

  _bindUpdate: ->
    self = this
    @$el.on 'change', '.property-name', ->
      $i = $(this)
      name = self.template.replace('__name__', $i.val())
      $i.closest('.property').
        find('input[name]').
        prop('name', name)

class PropertiesSelector extends PropertiesEditor
  constructor: ->
    super
    @propertyTemplate = @$list.find('.property')[0].outerHTML

  _bindAdd: ->
    self = this
    @$el.on 'click', '.add-property', ->
      $template = $(self.propertyTemplate)
      $template.find('input').val('')
      self.$list.append($template)
      false


$(document).on 'page:change', ->
  $editors = $('.properties-editor')
  if $editors.length
    $editors.each -> new PropertiesEditor($(this))

  $selectors = $('.properties-selector')
  if $selectors.length
    $selectors.each -> new PropertiesSelector($(this))
