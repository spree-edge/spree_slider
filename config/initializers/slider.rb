Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.add_to_section(
      'settings',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'slider_locations',
        ::Spree::Core::Engine.routes.url_helpers.admin_slide_locations_path
      )
      .with_manage_ability_check(::Spree::SlideLocation)
      .build
    )

    Rails.application.config.spree_backend.main_menu.add_to_section(
      'settings',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'slides',
        ::Spree::Core::Engine.routes.url_helpers.admin_slides_path
      )
      .with_manage_ability_check(::Spree::Slide)
      .build
    )
  end
end
