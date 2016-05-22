class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all

    # Require the gems
    require 'capybara/poltergeist'
    require 'httparty'
    require 'byebug'

    # Configure Poltergeist to not blow up on websites with js errors aka every website with js
    # See more options at https://github.com/teampoltergeist/poltergeist#customization
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, js_errors: false)
    end

    # Configure Capybara to use Poltergeist as the driver
    Capybara.default_driver = :poltergeist

    browser = Capybara.current_session
    url = 'http://www.bcpa.net/RecName.asp'
    browser.visit url

    name = 'STEWART,BALDWIN'

    browser.find('#Text1').set(name)
    browser.find("a[href='javascript:MM_Edit();']").click

    # browser.save_and_open_page

    # IF broswer.page = 'http://www.bcpa.net/RecSearch.asp' THEN skip to next record

    prop_addr = browser.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[1]/table/tbody/tr[1]/td[2]/span')[0].text
    owner = browser.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[1]/table/tbody/tr[2]/td[2]/span')[0].text
    mail_addr = browser.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[1]/table/tbody/tr[3]/td[2]/span')[0].text
    abbr_legal_desc = browser.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[3]/tbody/tr/td[2]/span')[0].text
    prop_id = browser.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[3]/table/tbody/tr[1]/td[2]/span')[0].text
    home_value = browser.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[5]/tbody/tr[3]/td[4]/span')[0].text


    puts owner
    puts prop_addr
    puts mail_addr
    puts abbr_legal_desc
    puts prop_id
    puts home_value

    # prop_addr = "3940 INVERRARY BOULEVARD 301-A, LAUDERHILL"
    # mail_addr = "3940 INVERRARY BLVD APT 301-A LAUDERHILL FL 33319-4344"
    #
    #
    # search_addr = prop_addr.gsub(" ","+").gsub("-","+")
    # api_key = 'AIzaSyDa1BWxkgm1n3tljbV-J_6bo3r7jV1UsD4'
    #
    # url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{search_addr}&key=#{api_key}"
    # response = HTTParty.get url
    #
    # dom = Nokogiri::HTML(response.body)
    # parsed = JSON.parse(dom)
    # address_components = parsed['results'][0]['address_components']
    #
    # prop_str_addr = "#{address_components[0]["long_name"]} #{address_components[1]["long_name"]}"
    # prop_city = "#{address_components[3]["long_name"]}"
    # prop_state = "#{address_components[5]["short_name"]}"
    # prop_zip = "#{address_components[7]["long_name"]}"
    # prop_county = "#{address_components[4]["long_name"]}"
    #
    # name = 'STEWART,BALDWIN'
    # Property.find_by(owner: name).update(prop_str_addr: prop_str_addr)
    # Property.find_by(owner: name).update(prop_city: prop_city)
    # Property.find_by(owner: name).update(prop_state: prop_state)
    # Property.find_by(owner: name).update(prop_zip: prop_zip)
    # Property.find_by(owner: name).update(prop_county: prop_county)

  end

  # def use_cabybara
  #   # Require the gems
  #   require 'capybara/poltergeist'
  #   require 'httparty'
  #
  #   # Configure Poltergeist to not blow up on websites with js errors aka every website with js
  #   # See more options at https://github.com/teampoltergeist/poltergeist#customization
  #   Capybara.register_driver :poltergeist do |app|
  #    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  #   end
  #
  #   # Configure Capybara to use Poltergeist as the driver
  #   Capybara.default_driver = :poltergeist
  # end

  # def get_CSV
  #   require 'capybara/poltergeist'
  #   require 'httparty'
  #   use_cabybara
  #
  #   # set browser
  #   browser = Capybara.current_session
  #   url = "https://officialrecords.broward.org/OncoreV2/search.aspx"
  #   browser.visit url
  #
  #   # navigate to url and set search criteria
  #   browser.click_on('Document Type')
  #   browser.fill_in('txtDocTypes', :with => 'LP')
  #   browser.within('#trBeginDate') do
  #    browser.click_on('Yesterday')
  #   end
  #   browser.within('#trEndDate') do
  #    browser.click_on('Today')
  #   end
  #
  #   # click search and wait
  #   browser.click_on('cmdSubmit')
  #   sleep 1
  #
  #   csv_url = browser.current_url
  #
  #   browser.driver.headers = {
  #   'Accept-Encoding' => 'gzip, deflate, sdch',
  #   'Accept-Language' => 'en-US,en;q=0.8',
  #   'Upgrade-Insecure-Requests' => '1',
  #   'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36',
  #   'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,​*/*​;q=0.8',
  #   'Connection' => 'keep-alive',
  #   'Referer' => csv_url,
  #   'Cookie' => "LastUrl=#{csv_url}; ASP.NET_SessionId=elxjso2ds2nr0s45bfdm1cjp; ImageIdsCookie=DocumentImageIds=106426052; LargeImageValues=DocumentImgIds=106426052&CurrentPageNumber=1&NumberOfImages=1; OnCoreWeb=AutoLoadImages=-1&ImageViewer=2&DefaultNumberOfRows=500&DisablePDFStreaming=False; OnCoreWebAuthenticated=Authenticated=0&AgentKey=-1&CacheKey=70942759.3342"
  #   }
  #
  #   download_url = 'https://officialrecords.broward.org/OncoreV2/Export.aspx'
  #   browser.execute_script("window.downloadCSVXHR = function(){ var url = '#{download_url}'; return getFile(url); }")
  #   browser.execute_script("window.getFile = function(url) { var xhr = new XMLHttpRequest();  xhr.open('GET', url, false);  xhr.send(null); return xhr.responseText; }")
  #   data = browser.evaluate_script("downloadCSVXHR()")
  #
  #   # File.write('broward.csv', data)
  #   data = CSV.read('broward.csv')
  #   #get rid of the header info
  #   data.slice!(0)
  #
  #   extract_CSV_data(data)
  # end


  # def extract_CSV_data(data)
  #   data.each do |property|
  #     document_num = property[0]
  #     owner = property[1]
  #     record_date = property[7]
  #     doc_number_lp = property[10]
  #
  #     p owner
  #
  #     get_assessor_data(owner, document_num, record_date, doc_number_lp)
  #   end
  # end


  # def get_assessor_data(owner, document_num, record_date, doc_number_lp)
  #   use_cabybara
  #
  #   browser2 = Capybara.current_session
  #   url = 'http://www.bcpa.net/RecName.asp'
  #   browser2.visit url
  #
  #   browser2.find('#Text1').set(owner)
  #   who_is_this = browser2.find('#Text1').set(owner)
  #   p who_is_this
  #   sleep 1
  #
  #   byebug
  #
  #   browser.find('#Text1').set(name)
  #   browser.find("a[href='javascript:MM_Edit();']").click
  #
  #   browser2.find("a[href='javascript:MM_Edit();']").click
  #   what_is_this = browser2.find("a[href='javascript:MM_Edit();']")
  #   p what_is_this
  #   sleep 1
  #
  #   p browser2.current_url
  #
  #   # IF broswer.page = 'http://www.bcpa.net/RecSearch.asp' THEN skip to next record
  #
  #   byebug
  #
  #
  #   if browser2.current_url.include? 'http://www.bcpa.net/RecSearch.asp'
  #     #save the incomplete record to the partial model
  #     byebug
  #     Partial.create(:document_num => document_num,
  #                     :owner => owner,
  #                     :record_date => record_date,
  #                     :doc_number_lp => doc_number_lp)
  #     # next
  #   else
  #     p browser2.current_url
  #     prop_addr = browser2.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[1]/table/tbody/tr[1]/td[2]/span')[0].text
  #     # overwrite owner with owner(s) from more accurate data source
  #     owner = browser2.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[1]/table/tbody/tr[2]/td[2]/span')[0].text
  #     mail_addr = browser2.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[1]/table/tbody/tr[3]/td[2]/span')[0].text
  #     abbr_legal_desc = browser2.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[3]/tbody/tr/td[2]/span')[0].text
  #     prop_id = browser2.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[1]/tbody/tr/td[3]/table/tbody/tr[1]/td[2]/span')[0].text
  #     home_value = browser2.all(:xpath, '/html/body/table[2]/tbody/tr/td/table/tbody/tr[1]/td[1]/table[5]/tbody/tr[3]/td[4]/span')[0].text
  #     #begin to save the complete record to the property model
  #     parse_property_data(prop_addr)
  #     parse_mailing_data(mail_addr)
  #     #finish to save the complete record after parsing
  #     create_new_property
  #   end
  # end

  # # search google geocode api for breakout of address components for property address
  # def parse_property_data(prop_addr)
  #
  #   p "made it into parse_property_data"
  #   byebug
  #
  #   search_addr = prop_addr.gsub(" ","+").gsub("-","+")
  #   api_key = 'AIzaSyDa1BWxkgm1n3tljbV-J_6bo3r7jV1UsD4'
  #
  #   url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{search_addr}&key=#{api_key}"
  #   response = HTTParty.get url
  #
  #   dom = Nokogiri::HTML(response.body)
  #   parsed = JSON.parse(dom)
  #   address_components = parsed['results'][0]['address_components']
  #
  #   prop_str_addr = "#{address_components[0]["long_name"]} #{address_components[1]["long_name"]}"
  #   prop_city = "#{address_components[3]["long_name"]}"
  #   prop_state = "#{address_components[5]["short_name"]}"
  #   prop_zip = "#{address_components[7]["long_name"]}"
  #   prop_county = "#{address_components[4]["long_name"]}"
  # end


  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:owner, :prop_str_addr, :prop_city, :prop_state, :prop_zip, :prop_county, :home_value, :prop_acct_num, :legal_desc, :document_num, :record_date, :doc_number_lp, :mail_str_addr, :mail_city, :mail_state, :mail_zip, :mail_county)
    end
end
