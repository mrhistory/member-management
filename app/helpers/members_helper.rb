module MembersHelper

  def allow_edits
      APP_CONFIG[:allow_member_record_edits]
  end

  def us_states
    array = []
    array.push(State.new('AL', 'Alabama'))
    array.push(State.new('AK', 'Alaska'))
    array.push(State.new('AZ', 'Arizona'))
    array.push(State.new('AR', 'Arkansas'))
    array.push(State.new('CA', 'California'))
    array.push(State.new('CO', 'Colorado'))
    array.push(State.new('CT', 'Connecticut'))
    array.push(State.new('DE', 'Delaware'))
    array.push(State.new('DC', 'District of Columbia'))
    array.push(State.new('FL', 'Florida'))
    array.push(State.new('GA', 'Georgia'))
    array.push(State.new('HI', 'Hawaii'))
    array.push(State.new('ID', 'Idaho'))
    array.push(State.new('IL', 'Illinois'))
    array.push(State.new('IN', 'Indiana'))
    array.push(State.new('IA', 'Iowa'))
    array.push(State.new('KS', 'Kansas'))
    array.push(State.new('KY', 'Kentucky'))
    array.push(State.new('LA', 'Louisiana'))
    array.push(State.new('ME', 'Maine'))
    array.push(State.new('MD', 'Maryland'))
    array.push(State.new('MA', 'Massachusetts'))
    array.push(State.new('MI', 'Michigan'))
    array.push(State.new('MN', 'Minnesota'))
    array.push(State.new('MS', 'Mississippi'))
    array.push(State.new('MO', 'Missouri'))
    array.push(State.new('MT', 'Montana'))
    array.push(State.new('NE', 'Nebraska'))
    array.push(State.new('NV', 'Nevada'))
    array.push(State.new('NH', 'New Hampshire'))
    array.push(State.new('NJ', 'New Jersey'))
    array.push(State.new('NM', 'New Mexico'))
    array.push(State.new('NY', 'New York'))
    array.push(State.new('NC', 'North Carolina'))
    array.push(State.new('ND', 'North Dakota'))
    array.push(State.new('OH', 'Ohio'))
    array.push(State.new('OK', 'Oklahoma'))
    array.push(State.new('OR', 'Oregon'))
    array.push(State.new('PA', 'Pennsylvania'))
    array.push(State.new('RI', 'Rhode Island'))
    array.push(State.new('SC', 'South Carolina'))
    array.push(State.new('SD', 'South Dakota'))
    array.push(State.new('TN', 'Tennessee'))
    array.push(State.new('TX', 'Texas'))
    array.push(State.new('UT', 'Utah'))
    array.push(State.new('VT', 'Vermont'))
    array.push(State.new('VA', 'Virgina'))
    array.push(State.new('WA', 'Washington'))
    array.push(State.new('WV', 'West Virginia'))
    array.push(State.new('WI', 'Wisconsin'))
    array.push(State.new('WY', 'Wyoming'))
    return array
  end


  class State
    attr_accessor :abbr, :name

    def initialize(abbr, name)
      @abbr = abbr
      @name = name
    end
  end

end
