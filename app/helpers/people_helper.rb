module PeopleHelper
  def h_card_code(person)
    html = ""
    tab  = "  "

    html << h(%Q{<div class="h-card">})
      html << tag(:br)

      # photo
      unless person.photo.blank?
        html << tab
        html << h(%Q{<img src="#{person.photo}" class="u-photo" />})
        html << tag(:br)
      end

      # name and personal_website url
      if !person.name.blank? && !person.personal_website.blank?
        html << tab
        html << h(%Q{<a href="#{person.personal_website}" class="p-name u-url">#{person.name}</a>})
        html << tag(:br)
      else
        # just name
        unless person.name.blank?
          html << tab
          html << h(%Q{<span class="p-name">#{person.name}</span>})
          html << tag(:br)
        end

        # just personal_website url
        unless person.personal_website.blank?
          html << tab
          html << h(%Q{<a href="#{person.personal_website}" class="p-url">#{person.personal_website}</a>})
          html << tag(:br)
        end
      end

      # email
      unless person.email.blank?
        html << tab
        html << h(%Q{<a href="mailto:#{person.email}" class="u-email">#{person.email}</a>})
        html << tag(:br)
      end

      # elsewhere urls
      unless person.urls.blank?
        urls = person.urls.split(/\s/).map{ |u| u unless u.blank? }.compact

        if urls.length > 1
          html << tab
          html << h(%Q{<ul>})
          html << tag(:br)
        end

        urls.each do |url|
          html << tab
          html << tab if urls.length > 1
          html << h(%Q{<li>}) if urls.length > 1
          html << h(%Q{<a href="#{url}" class="u-url" rel="me">#{url}</a></li>})
          html << h(%Q{</li>}) if urls.length > 1
          html << tag(:br)
        end

        if urls.length > 1
          html << tab
          html << h(%Q{</ul>})
          html << tag(:br)
        end
      end

      # timezone offset
      unless person.timezone.blank?
        html << tab
        html << h(%Q{<data class="p-tz" value="#{person.timezone.offset}">#{person.timezone.name}</data>})
        html << tag(:br)
      end

      # birthday
      unless person.birthday.blank?
        html << tab
        html << h(%Q{<data class="p-bday" value="#{person.birthday.strftime('%Y-%m-%d')}">#{person.birthday.strftime('%B %d, %Y')}</data>})
        html << tag(:br)
      end

      # chat usernames
      unless person.chat_usernames.blank?
        chat_usernames = person.chat_usernames.split(/\s|,/).map{ |cu| cu unless cu.blank? }.compact

        if chat_usernames.length > 1
          html << tab
          html << h(%Q{<ul>})
          html << tag(:br)
        end

        chat_usernames.each do |chat_username|
          html << tab
          html << tab if chat_usernames.length > 1
          html << h(%Q{<li>}) if chat_usernames.length > 1
          html << h(%Q{#{chat_username}})
          html << h(%Q{</li>}) if chat_usernames.length > 1
          html << tag(:br)
        end

        if chat_usernames.length > 1
          html << tab
          html << h(%Q{</ul>})
          html << tag(:br)
        end
      end

      # note
      unless person.additional_info.blank?
        html << tab
        html << h(%Q{<div class="p-note"><!-- Add anything else you want here: bio, notes, etc --></div>})
        html << tag(:br)
      end

    html << h(%Q{</div><!-- .h-card -->})
    html.html_safe
  end
end
