module "wrapper" {
  source = "../../modules/deploy"

  for_each = var.items

  create                          = try(each.value.create, var.defaults.create, true)
  tags                            = try(each.value.tags, var.defaults.tags, {})
  alias_name                      = try(each.value.alias_name, var.defaults.alias_name, "")
  function_name                   = try(each.value.function_name, var.defaults.function_name, "")
  current_version                 = try(each.value.current_version, var.defaults.current_version, "")
  target_version                  = try(each.value.target_version, var.defaults.target_version, "")
  before_allow_traffic_hook_arn   = try(each.value.before_allow_traffic_hook_arn, var.defaults.before_allow_traffic_hook_arn, "")
  after_allow_traffic_hook_arn    = try(each.value.after_allow_traffic_hook_arn, var.defaults.after_allow_traffic_hook_arn, "")
  interpreter                     = try(each.value.interpreter, var.defaults.interpreter, ["/bin/bash", "-c"])
  description                     = try(each.value.description, var.defaults.description, "")
  create_app                      = try(each.value.create_app, var.defaults.create_app, false)
  use_existing_app                = try(each.value.use_existing_app, var.defaults.use_existing_app, false)
  app_name                        = try(each.value.app_name, var.defaults.app_name, "")
  create_deployment_group         = try(each.value.create_deployment_group, var.defaults.create_deployment_group, false)
  use_existing_deployment_group   = try(each.value.use_existing_deployment_group, var.defaults.use_existing_deployment_group, false)
  deployment_group_name           = try(each.value.deployment_group_name, var.defaults.deployment_group_name, "")
  deployment_config_name          = try(each.value.deployment_config_name, var.defaults.deployment_config_name, "CodeDeployDefault.LambdaAllAtOnce")
  auto_rollback_enabled           = try(each.value.auto_rollback_enabled, var.defaults.auto_rollback_enabled, true)
  auto_rollback_events            = try(each.value.auto_rollback_events, var.defaults.auto_rollback_events, ["DEPLOYMENT_STOP_ON_ALARM"])
  alarm_enabled                   = try(each.value.alarm_enabled, var.defaults.alarm_enabled, false)
  alarms                          = try(each.value.alarms, var.defaults.alarms, [])
  alarm_ignore_poll_alarm_failure = try(each.value.alarm_ignore_poll_alarm_failure, var.defaults.alarm_ignore_poll_alarm_failure, false)
  triggers                        = try(each.value.triggers, var.defaults.triggers, {})
  aws_cli_command                 = try(each.value.aws_cli_command, var.defaults.aws_cli_command, "aws")
  save_deploy_script              = try(each.value.save_deploy_script, var.defaults.save_deploy_script, false)
  create_deployment               = try(each.value.create_deployment, var.defaults.create_deployment, false)
  run_deployment                  = try(each.value.run_deployment, var.defaults.run_deployment, false)
  force_deploy                    = try(each.value.force_deploy, var.defaults.force_deploy, false)
  wait_deployment_completion      = try(each.value.wait_deployment_completion, var.defaults.wait_deployment_completion, false)
  create_codedeploy_role          = try(each.value.create_codedeploy_role, var.defaults.create_codedeploy_role, true)
  codedeploy_role_name            = try(each.value.codedeploy_role_name, var.defaults.codedeploy_role_name, "")
  codedeploy_principals           = try(each.value.codedeploy_principals, var.defaults.codedeploy_principals, ["codedeploy.amazonaws.com"])
  attach_hooks_policy             = try(each.value.attach_hooks_policy, var.defaults.attach_hooks_policy, true)
  attach_triggers_policy          = try(each.value.attach_triggers_policy, var.defaults.attach_triggers_policy, false)
  get_deployment_sleep_timer      = try(each.value.get_deployment_sleep_timer, var.defaults.get_deployment_sleep_timer, 5)
}
