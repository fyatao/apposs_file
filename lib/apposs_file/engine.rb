module AppossFile
  class Engine < ::Rails::Engine
    isolate_namespace AppossFile
    config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]  
  end
end
