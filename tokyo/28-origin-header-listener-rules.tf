resource "aws_lb_listener_rule" "bos_allow_origin_header01" {
  listener_arn = aws_lb_listener.bos_https_listener01.arn
  priority     = 10

  condition {
    http_header {
      http_header_name = "X-Origin-Verify"
      values           = [random_string.origin_header_value.result]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bos_tg01.arn
  }
}

resource "aws_lb_listener_rule" "bos_deny_missing_origin_header01" {
  listener_arn = aws_lb_listener.bos_https_listener01.arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type = "fixed-response"
    fixed_response {
      status_code  = "403"
      content_type = "text/plain"
      message_body = "Forbidden"
    }
  }
}

resource "aws_lb_listener_rule" "bos_allow_origin_header_http" {
  listener_arn = aws_lb_listener.bos_http_listener01.arn
  priority     = 110

  condition {
    http_header {
      http_header_name = "X-Origin-Verify"
      values           = [random_string.origin_header_value.result]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bos_tg01.arn
  }
}

resource "aws_lb_listener_rule" "bos_deny_missing_origin_header_http" {
  listener_arn = aws_lb_listener.bos_http_listener01.arn
  priority     = 120

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type = "fixed-response"

    fixed_response {
      status_code  = "403"
      content_type = "text/plain"
      message_body = "Forbidden"
    }
  }
}

