ActiveAdmin.register PageView do
  config.sort_order = "id_desc"
  config.per_page = 50
  menu parent: "Items", label: 'All Page Views', priority: 8
  actions :index, :show
  filter :locale, label: "Language"
  filter :created_at, label: "Date"
  sidebar :per_page, partial: "per_page", only: :index

  index title: "Page Views" do
    column "", sortable: false do |t|
      link_to t.item.id, t.item, target: "_blank"
    end
    column "Article", sortable: :item_id do |t|
      link_to t.item.title.truncate(46), t.item, target: "_blank"
    end
    column "Time", sortable: :created_at do |t|
      t.created_at.to_s(:short) if t.created_at
    end
    column "IP", sortable: false do |t|
      link_to(t.user_ip, "http://www.geoiptool.com/en/?IP=#{t.user_ip}", target: "_blank") if t.user_ip.present?
    end
    column "User", sortable: :user_id do |t|
      link_to t.user.public_display_name, admin_user_path(t.user) if t.user
    end
    column "Referrer", sortable: false do |t|
      link_to("URL", t.referrer, title: t.referrer, taget: "_blank") if t.referrer.present?
    end
    column "Lang", :locale
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :locale
      row :item
      row :user
      row :user_ip
      row :user_agent
      row :referrer
      row :updated_at
      row :created_at
    end
  end

  controller do
    def scoped_collection
      PageView.includes(:item, :user)
    end
  end
end
