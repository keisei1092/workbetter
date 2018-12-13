# form_withをAjaxにしない（エラー表示が出なくなってしまう）
Rails.application
  .config
  .action_view
  .form_with_generates_remote_forms = false
