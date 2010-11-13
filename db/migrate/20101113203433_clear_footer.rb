class ClearFooter < ActiveRecord::Migration
  def self.up
    Footer.first.update_attributes({:content => ""}) 
    MainPage.first.update_attributes({:right_bottom_content => "", :title => "", :body => ""})
    Header.first.update_attributes({:content => ""})
    asset = Asset.create({:document => File.open("#{RAILS_ROOT}/public/images/main_small.jpg")})
    MainPage.first.update_attributes({:body => "
      <img src='#{asset.document.url}' alt='image' />                                
      <p>Eros in rhoncus cras tincidunt odio vel tincidunt sagittis vel turpis lectus. Nisi, cum in, porttitor? Amet cras, nec et eu enim, tristique hac! Facilisis pellentesque dolor ridiculus purus? Porta cras turpis, adipiscing natoque risus cras ultricies natoque elementum auctor sit urna aliquam dignissim, porttitor ac porta quis, turpis! Velit enim porttitor? In arcu est porttitor, et? Turpis. Penatibus rhoncus nunc lectus odio! Eros vel platea. Diam amet, ultrices! Dolor, proin sagittis, enim ut in arcu ut aliquet scelerisque diam! In, lorem pid natoque tristique, urna sed ut sagittis pulvinar? Enim, sed. Urna in integer et! Augue porttitor turpis, vel lorem purus sed urna, lacus sit adipiscing? Lacus, velit pulvinar. Et ultrices est lorem massa adipiscing cras et nisi auctor.</p>
      <p>Phasellus enim tincidunt? Porttitor elementum! Urna lundium pulvinar facilisis, elit lorem pulvinar sagittis amet vel. Cum lacus placerat porttitor mid dapibus placerat et? Ut proin mauris scelerisque? Ac ridiculus. Adipiscing facilisis tincidunt facilisis! Pulvinar, augue! Turpis mattis magnis? Elit. In ac cursus odio? Platea turpis adipiscing hac turpis dignissim placerat pulvinar facilisis nisi! Lundium nec, ac nunc? Tincidunt risus, elit, eros a lorem vel et, dignissim cursus, a arcu enim dis? In integer turpis, a est elementum urna rhoncus amet eros ultrices, tempor. Tincidunt mattis, penatibus ac turpis augue parturient enim urna phasellus nisi! Amet! Est diam phasellus elementum? Vut habitasse in pid, etiam, est tortor nunc? Eu et? Scelerisque. Velit diam vel purus amet, dictumst ut massa aliquam.</p>"})
  end

  def self.down

  end
end
