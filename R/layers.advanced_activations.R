#' Advanced activation layers
#'
#' @param alpha                   float >= 0. Negative slope coefficient in \code{LeakyReLU}
#'                                and scale for the negative factor in \code{ELU}.
#' @param theta                   float >= 0. Threshold location of activation in \code{ThresholdedReLU}.
#' @param input_shape             only need when first layer of a model; sets the input shape
#'                                  of the data
#' @examples
#' if (run_examples()) {
#'
#' X_train <- matrix(rnorm(100 * 10), nrow = 100)
#' Y_train <- to_categorical(matrix(sample(0:2, 100, TRUE), ncol = 1), 3)
#'
#' mod <- Sequential()
#' mod$add(Dense(units = 50, input_shape = dim(X_train)[2]))
#' mod$add(LeakyReLU(alpha = 0.4))
#' mod$add(Dense(units = 50))
#' mod$add(ELU(alpha = 0.5))
#' mod$add(Dense(units = 50))
#' mod$add(ThresholdedReLU(theta = 1.1))
#' mod$add(Dense(units = 3))
#' mod$add(Activation("softmax"))
#' keras_compile(mod,  loss = 'categorical_crossentropy', optimizer = RMSprop())
#'
#' keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 5, verbose = 0)
#'
#' }
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @name AdvancedActivation
NULL

#' @rdname AdvancedActivation
#' @export
LeakyReLU <- function(alpha = 0.3, input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.advanced_activations$LeakyReLU(alpha = alpha)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.advanced_activations$LeakyReLU(alpha = alpha, input_shape = input_shape)

  }

  return(res)
}

#' @rdname AdvancedActivation
#' @export
PReLU <- function(input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.advanced_activations$PReLU()
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.advanced_activations$PReLU(input_shape = input_shape)

  }

  return(res)
}

#' @rdname AdvancedActivation
#' @export
ELU <- function(alpha = 1.0, input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.advanced_activations$ELU(alpha = alpha)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.advanced_activations$ELU(alpha = alpha, input_shape = input_shape)

  }

  return(res)
}

#' @rdname AdvancedActivation
#' @export
ThresholdedReLU <- function(theta = 1.0, input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.advanced_activations$ThresholdedReLU(theta = theta)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.advanced_activations$ThresholdedReLU(theta = theta, input_shape = input_shape)

  }

  return(res)
}


