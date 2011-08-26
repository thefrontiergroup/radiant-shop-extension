module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"

    when "the first more details link"
      "p.more_details > a"

    when "the correct answer"
      "li.correct"

    when "the incorrect answer"
      "li.incorrect"

    when "the question area"
      ".question"

    when "the question translation"
      ".question-translation"

    when "the answer translation"
      ".answer-translation"

    when "my subscriptions"
      ".subscription"

    when "my recent sessions"
      ".session-info"

    when "the question section"
      ".question"

    when "the performance overview graph"
      "aside#side div#dashboard-my-perfomance-graph"

    when "the session performance"
      "#session-performance"

    when 'the progressed time percentage'
      '#exam-timer .progress-label'

    when 'the popup dialog'
      '#fancybox-content'

    when 'the footer links'
      '#footer .links'

    when 'the header overlay'
      '#overlays #header-overlay'

    when 'the exam score'
      'td.score'

    when 'the exam status'
      'td.status'

    when 'the section inputs'
      '#sections'

    when 'the last row'
      'table tr:last'

    when 'the keyboard shortcut information'
      '.keyboard-tip'

    when 'the product on the first row'
      'tbody tr:first td.title'

    when 'the total price'
      'tfoot td.total-price'

    when 'the subtotal price'
      'tfoot td.subtotal-price'

    when 'the discount'
      'tfoot td.discount-price'

    when 'the title column'
      'tbody tr td.title'

    when 'the content provider column'
      'tbody tr td.content_provider'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #  when /^the (notice|error|info) flash$/
    #    ".flash.#{$1}"

    # You can also return an array to use a different selector
    # type, like:
    #
    #  when /the header/
    #    [:xpath, "//header"]

    # This allows you to provide a quoted selector as the scope
    # for "within" steps as was previously the default for the
    # web steps:
    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)
