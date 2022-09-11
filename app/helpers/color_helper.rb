# typed: strict
# frozen_string_literal: true

module ColorHelper
  extend T::Sig

  class Shade < T::Enum
    enums do
      Fifty = new(50)
      OneHundred = new(100)
      TwoHundred = new(200)
      # TODO: add other shades
    end
  end

  class Color < T::Enum
    enums do
      Blue   = new
      Gray   = new
      Green  = new
      Red    = new
      Yellow = new
    end
  end

  sig { params(color: Color, shade: Shade).returns(String) }
  def bg(color, shade)
    case shade
    when Shade::Fifty then bg50(color)
    when Shade::OneHundred then bg100(color)
    when Shade::TwoHundred then bg200(color)
    else T.absurd(shade)
    end
  end

  # We have to write out the class name in full for PurgeCSS to work
  # properly.

  sig { params(color: Color).returns(String) }
  def bg50(color)
    case color
    when Color::Blue   then 'bg-blue-50'
    when Color::Gray   then 'bg-gray-50 dark:bg-gray-900'
    when Color::Green  then 'bg-green-50'
    when Color::Red    then 'bg-red-50'
    when Color::Yellow then 'bg-yellow-50'
    else T.absurd(color)
    end
  end

  sig { params(color: Color).returns(String) }
  def bg100(color)
    case color
    when Color::Blue   then 'bg-blue-100'
    when Color::Gray   then 'bg-gray-100 dark:bg-gray-800'
    when Color::Green  then 'bg-green-100'
    when Color::Red    then 'bg-red-100'
    when Color::Yellow then 'bg-yellow-100'
    else T.absurd(color)
    end
  end

  sig { params(color: Color).returns(String) }
  def bg200(color)
    case color
    when Color::Blue   then 'bg-blue-200'
    when Color::Gray   then 'bg-gray-200 dark:bg-gray-700'
    when Color::Green  then 'bg-green-200'
    when Color::Red    then 'bg-red-200'
    when Color::Yellow then 'bg-yellow-200'
    else T.absurd(color)
    end
  end

  sig { params(color: Color).returns(String) }
  def text700(color)
    case color
    when Color::Blue   then 'text-blue-700'
    when Color::Gray   then 'text-gray-700 dark:text-gray-200'
    when Color::Green  then 'text-green-700'
    when Color::Red    then 'text-red-700'
    when Color::Yellow then 'text-yellow-700'
    else T.absurd(color)
    end
  end

  sig { params(color: Color).returns(String) }
  def text800(color)
    case color
    when Color::Blue   then 'text-blue-800'
    when Color::Gray   then 'text-gray-800 dark:text-gray-100'
    when Color::Green  then 'text-green-800'
    when Color::Red    then 'text-red-800'
    when Color::Yellow then 'text-yellow-800'
    else T.absurd(color)
    end
  end
end
