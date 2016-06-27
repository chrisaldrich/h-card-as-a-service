require "open-uri"
require "json"
require "rouge"

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all
  end

  def show
    @people = [@person]

    if @people.blank?
      redirect_to root_path
    end
  end

  def nickname
    @people = Nickname.where(name: params[:nickname]).all.map{ |n| n.person }

    if @people.blank?
      redirect_to root_path
    else
      render :show
    end
  end

  def new
    website = params[:website]
    @person = Person.new(personal_website: website)

    unless params[:website].blank?
      url = "https://pin13.net/mf2/?url=#{website}"
      parsed_microformats = JSON.parse(open(url).read)

      parsed_microformats["items"].each do |item|
        if item["type"].include?("h-card")
          # name
          if item["properties"]["name"].present?
            @person.name = item["properties"]["name"].first
          end

          # urls
          if item["properties"]["url"].present?
            urls = []
            item["properties"]["url"].each do |url|
              unless url.include?(website)
                urls << url
              end
            end
            @person.urls = urls.join(" ")
          end

          # photo
          if item["properties"]["photo"].present?
            @person.photo = item["properties"]["photo"].first
          end

          # email
          if item["properties"]["email"].present?
            @person.email = item["properties"]["email"].join(" ").gsub("mailto:", "")
          end

          # location
          location_pieces = []
          location_pieces << item["properties"]["locality"].try(:first)
          location_pieces << item["properties"]["region"].try(:first)
          location_pieces << item["properties"]["country-name"].try(:first)
          @person.location = location_pieces.compact.join(", ")

          # birthday (bday)
          if item["properties"]["bday"].present?
            @birthday = Date.parse(item["properties"]["bday"].first)
            @person.birthday = @birthday
          end

          # timezone offset (tz)
          if item["properties"]["tz"].present?
            @tz = item["properties"]["tz"].first
            timezone = Timezone.find_by(offset: item["properties"]["tz"].first.sub(":", ""))

            if timezone.nil?
              timezone = Timezone.find_by(name: item["properties"]["tz"].first)
            end

            @person.timezone = timezone if timezone.present?
          end

          # nicknames
          nicknames = []
          if item["properties"]["nickname"].present?
            item["properties"]["nickname"].each do |nickname|
              nicknames << nickname
            end
            @person.chat_usernames = nicknames.compact.uniq.join(", ")
          end

          # additional_info
          if item["properties"]["note"].present?
            @person.additional_info = item["properties"]["note"].join(" ")
          end
        end
      end

      source      = parsed_microformats.to_s
      formatter   = Rouge::Formatters::HTML.new
      lexer       = Rouge::Lexers::Shell.new
      @debug_info = formatter.format(lexer.lex(source))
    end
  end

  def edit
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to person_path(@person), notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: person_path(@person) }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_path(@person), notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: person_path(@person) }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_person
    @person = Person.find_by(domain: "#{params[:domain]}.#{params[:tld]}")
  end

  def person_params
    params.require(:person).permit(:name, :personal_website, :email, :urls, :timezone_id, :birthday, :chat_usernames, :photo, :additional_info)
  end
end
