class ReactComponent < ViewComponent::Base
  attr_reader :component, :raw_props

  # @param component [String] Component name
  # @param raw_props [Hash] Component props
  def initialize(component, raw_props: {})
    @component = component
    @raw_props = raw_props
  end

  # @return [String] Returns a React element to be rendered.
  def call
    helpers.tag.div("", data: {react_component: component, props: props})
  end

  private

  def props
    raw_props
  end
end
