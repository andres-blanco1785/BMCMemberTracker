# frozen_string_literal: true

module MembersHelper
  def expiration(mem_type, mem_date)
    if mem_type == 'N/A'
      'N/A'
    else
      @year = mem_date.year
      @next_year = @year + 1
      @month = mem_date.month

      case mem_type
      when 'one semester'
        if @month < 6
          "#{@year}-5-31"
        else
          "#{@year}-12-31"
        end
      when 'full year'
        if @month < 6
          "#{@year}-12-31"
        else
          "#{@next_year}-5-31"
        end
      else
        'N/A'
      end
    end
  end

  def status(expiration)
    if expiration == 'N/A'
      ''
    elsif Date.today < Date.parse(expiration)
      'Member'
    else
      'Expired'
    end
  end
end
