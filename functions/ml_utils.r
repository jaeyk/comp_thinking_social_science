############### REGRESSION ################

#’ Plot observed vs. predicted values for a regression model
#’
#’ @param model A fitted regression model
#’ @param model_name A descriptive name for the model (for the title)
#’ @return A ggplot2 scatterplot with a diagonal reference line
visualize_fit <- function(model, model_name) {
  # 1. Bind the true outcomes and the model’s predictions
  results <- bind_cols(
    tibble(truth = test_y_reg),          # true values
    predict(model, test_x_reg)           # predicted values (.pred)
  )

  # 2. Create the plot
  results %>%
    ggplot(aes(x = truth, y = .pred)) +
    geom_abline(linetype = "dashed", color = "gray60") +  # 45° reference
    geom_point(alpha = 0.5) +                              # scatter
    coord_obs_pred() +                                     # equal scales
    labs(
      title = glue::glue("{model_name} — Observed vs Predicted"),
      x     = "Observed",
      y     = "Predicted"
    )
}

#’ Compute regression metrics (e.g., RMSE, MAE)
#’
#’ @param model A fitted regression model
#’ @return A tibble of performance metrics
evaluate_reg <- function(model) {
  bind_cols(
    tibble(truth = test_y_reg),
    predict(model, test_x_reg)
  ) %>%
    metrics(truth = truth, estimate = .pred)
}


############# CLASSIFICATION ################

#’ Compute classification metrics (accuracy, sensitivity, etc.)
#’
#’ @param model A fitted classification model
#’ @return A tibble of performance metrics
evaluate_class <- function(model) {
  bind_cols(
    tibble(truth = test_y_class),        # true labels
    predict(model, test_x_class)         # predictions (.pred_class)
  ) %>%
    metrics(truth = truth, estimate = .pred_class)
}

#’ Bar chart of classification metrics
#’
#’ @param model A fitted classification model
#’ @return A ggplot2 bar chart with metric values
visualize_class_eval <- function(model) {
  evaluate_class(model) %>%
    mutate(metric = toupper(.metric)) %>%   # uppercase names
    ggplot(aes(x = fct_reorder(metric, .estimate), y = .estimate)) +
    geom_col(fill = "steelblue") +
    geom_text(aes(label = scales::percent(.estimate, accuracy = 1)),
              hjust = -0.1, color = "red", size = 3) +
    coord_flip() +
    labs(
      title = "Classification Performance",
      x     = "Metric",
      y     = "Estimate"
    ) +
    ylim(0, 1)
}

#’ Confusion matrix heatmap for a classification model
#’
#’ @param model A fitted classification model
#’ @return A ggplot2 tile plot of the confusion matrix
visualize_class_conf <- function(model) {
  bind_cols(
    tibble(truth = test_y_class),
    predict(model, test_x_class)
  ) %>%
    conf_mat(truth, .pred_class) %>%
    autoplot(type = "heatmap") +                # requires yardstick + ggplot2
    scale_fill_gradient(low = "white", high = "tomato") +
    labs(
      title = "Confusion Matrix",
      x     = "Predicted",
      y     = "Actual"
    )
}
