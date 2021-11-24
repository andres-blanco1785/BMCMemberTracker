# frozen_string_literal: true

module MembersHelper
  def expiration(mem_type, mem_date)
    if mem_type == ''
      ''
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
    if expiration == ''
      ''
    elsif Date.today < Date.parse(expiration)
      'Member'
    else
      'Expired'
    end
  end

  def add_email(email_list, mem_email)
    if email_list.nil?
      email_list = mem_email
    else
      email_list = email_list + ', ' + mem_email
    end
  end
end
