class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :block_bots
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params.fetch(:locale) { Idioma.configuration.default_locale }
  end

  def default_url_options(options={})
    default_options = if Setting.get(:i18n_activated)
      { locale: I18n.locale }
    else
      { locale: nil }
    end
    default_options.merge(options)
  end

  def block_bots
    return true if request.referrer.blank?
    return render(nothing: true, status: 400) if bot_array.include?(request.referrer.to_s.downcase)
    true
  end

  def bot_array
    [
      'semalt.com',
      'darodar.com',
      'priceg.com',
      '7makemoneyonline.com',
      'buttons-for-website.com',
      'ilovevitaly.com',
      'blackhatworth.com',
      'econom.co',
      'iskalko.ru',
      'lomb.co',
      'lombia.co',
      'hulfingtonpost.com',
      'cenoval.ru',
      'bestwebsitesawards.com',
      'o-o-6-o-o.com',
      'humanorightswatch.org',
      'forum20.smailik.org',
      'myftpupload.com',
      'prodvigator.ua',
      'best-seo-solution.com',
      'buttons-for-your-website.com',
      'buy-cheap-online.info',
      'offers.bycontext.com',
      'website-errors-scanner.com',
      'webmaster-traffic.com',
      'guardlink.org',
      'www.event-tracking.com',
      'trafficmonetize.org',
      'traffic-paradise.org',
      'simple-share-buttons.com',
      'sharebutton.org',
      's.click.aliexpress.com',
      'social-buttons.com',
      'site12.social-buttons.com',
      'anticrawler.org',
      'adcash.com',
      'adviceforum.info',
      'anticrawler.org',
      'blackhatworth.com',
      'cenokos.ru',
      'cityadspix.com',
      'edakgfvwql.ru',
      'gobongo.info',
      'iskalko.ru',
      'kambasoft.com',
      'luxup.ru',
      '4webmasters.org',
      'get-free-traffic-now.com',
      'best-seo-offer.com',
      'theguardlan.com',
      'www1.social-buttons.com',
      'netvibes.com',
      'webcrawler.com',
      'www.get-free-traffic-now.com',
      'sanjosestartups.com',
      'resellerclub.com',
      'savetubevideo.com',
      'screentoolkit.com',
      'seoexperimenty.ru',
      'slftsdybbg.ru',
      'socialseet.ru',
      'superiends.org',
      'vodkoved.ru',
      'websocial.me',
      'ykecwqlixx.ru',
      '76brighton.co.uk',
      'paparazzistudios.com.au',
      'powitania.pl',
      'sharebutton.net',
      'tasteidea.com',
      'descargar-musica-gratis.net',
      'torontoplumbinggroup.com',
      'cyprusbuyproperties.com',
      'ranksonic.org',
      'googlsucks.com',
      'free-share-buttons.com',
      'securesuite.co.uk',
      'securesuite.net',
      'www3.free-social-buttons.com',
      'free-social-buttons.com',
      'sitevaluation.org',
      'webmonetizer.net'
    ]
  end
end
