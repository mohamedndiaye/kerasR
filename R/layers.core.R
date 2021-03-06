#' Regular, densely-connected NN layer.
#'
#'  Dense implements the operation:
#'  `output = activation(dot(input, kernel) + bias)`
#'  where `activation` is the element-wise activation function
#'  passed as the `activation` argument, `kernel` is a weights matrix
#'  created by the layer, and `bias` is a bias vector created by the layer
#'  (only applicable if `use_bias` is `True`).
#'  Note: if the input to the layer has a rank greater than 2, then
#'  it is flattened prior to the initial dot product with `kernel`.
#'
#' @param units                  Positive integer, dimensionality of the output space.
#' @param activation             The activation function to use.
#' @param use_bias               Boolean, whether the layer uses a bias vector.
#' @param kernel_initializer     Initializer for the `kernel` weights matrix
#' @param bias_initializer       Initializer for the bias vector
#' @param kernel_regularizer     Regularizer function applied to the `kernel` weights matrix
#' @param bias_regularizer       Regularizer function applied to the bias vector
#' @param activity_regularizer   Regularizer function applied to
#'                               the output of the layer (its "activation").
#' @param kernel_constraint      Constraint function applied to  the `kernel` weights
#                                matrix
#' @param bias_constraint        Constraint function applied to the bias vector
#' @param input_shape            only need when first layer of a model; sets the input shape
#'                               of the data
#'
#' @examples
#' require('kerasR')
#' if (run_examples()) {
#' X_train <- matrix(rnorm(100 * 10), nrow = 100)
#' Y_train <- to_categorical(matrix(sample(0:2, 100, TRUE), ncol = 1), 3)
#'
#' mod <- Sequential()
#' mod$add(Dense(units = 50, input_shape = dim(X_train)[2]))
#' mod$add(Dropout(rate = 0.5))
#' mod$add(Activation("relu"))
#' mod$add(Dense(units = 3))
#' mod$add(ActivityRegularization(l1 = 1))
#' mod$add(Activation("softmax"))
#' keras_compile(mod,  loss = 'categorical_crossentropy', optimizer = RMSprop())
#'
#' keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 5,
#'           verbose = 0, validation_split = 0.2)
#' }
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
Dense <- function(units,
                  activation = "linear",
                  use_bias = TRUE,
                  kernel_initializer = "glorot_uniform",
                  bias_initializer = "zeros",
                  kernel_regularizer = NULL,
                  bias_regularizer = NULL,
                  activity_regularizer = NULL,
                  kernel_constraint = NULL,
                  bias_constraint = NULL,
                  input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Dense(units = int32(units),
                  activation = activation,
                  use_bias = use_bias,
                  kernel_initializer = kernel_initializer,
                  bias_initializer = bias_initializer,
                  kernel_regularizer = kernel_regularizer,
                  bias_regularizer = bias_regularizer,
                  activity_regularizer = activity_regularizer,
                  kernel_constraint = kernel_constraint,
                  bias_constraint = bias_constraint)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Dense(units = int32(units),
                  activation = activation,
                  use_bias = use_bias,
                  kernel_initializer = kernel_initializer,
                  bias_initializer = bias_initializer,
                  kernel_regularizer = kernel_regularizer,
                  bias_regularizer = bias_regularizer,
                  activity_regularizer = activity_regularizer,
                  kernel_constraint = kernel_constraint,
                  bias_constraint = bias_constraint,
                  input_shape = input_shape)
  }

  return(res)
}

#' Applies an activation function to an output.
#'
#' @param activation             name of activation function to use. See Details
#'                               for possible options.
#' @param input_shape            only need when first layer of a model; sets the input shape
#'                               of the data
#'
#' @details Possible activations include 'softmax', 'elu', 'softplus', 'softsign',
#'          'relu', 'tanh', 'sigmoid', 'hard_sigmoid', 'linear'. You may also
#'          set this equal to any of the outputs from an \link{AdvancedActivation}.
#'
#' @examples
#' if (run_examples()) {
#' X_train <- matrix(rnorm(100 * 10), nrow = 100)
#' Y_train <- to_categorical(matrix(sample(0:2, 100, TRUE), ncol = 1), 3)
#'
#' mod <- Sequential()
#' mod$add(Dense(units = 50, input_shape = dim(X_train)[2]))
#' mod$add(Dropout(rate = 0.5))
#' mod$add(Activation("relu"))
#' mod$add(Dense(units = 3))
#' mod$add(ActivityRegularization(l1 = 1))
#' mod$add(Activation("softmax"))
#' keras_compile(mod,  loss = 'categorical_crossentropy', optimizer = RMSprop())
#'
#' keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 5,
#'           verbose = 0, validation_split = 0.2)
#' }
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
Activation <- function(activation, input_shape = NULL) {
  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Activation(activation = activation)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Activation(activation = activation,
                                                input_shape = input_shape)

  }

  return(res)
}

#' Applies Dropout to the input.
#'
#' @param rate          float between 0 and 1. Fraction of the input units to drop.
#' @param noise_shape   1D integer tensor representing the shape of the binary
#                       dropout mask that will be multiplied with the input.
#' @param seed          A Python integer to use as random seed.
#' @param input_shape   only need when first layer of a model; sets the input shape
#'                               of the data
#'
#' @examples
#' if (run_examples()) {
#' X_train <- matrix(rnorm(100 * 10), nrow = 100)
#' Y_train <- to_categorical(matrix(sample(0:2, 100, TRUE), ncol = 1), 3)
#'
#' mod <- Sequential()
#' mod$add(Dense(units = 50, input_shape = dim(X_train)[2]))
#' mod$add(Dropout(rate = 0.5))
#' mod$add(Activation("relu"))
#' mod$add(Dense(units = 3))
#' mod$add(ActivityRegularization(l1 = 1))
#' mod$add(Activation("softmax"))
#' keras_compile(mod,  loss = 'categorical_crossentropy', optimizer = RMSprop())
#'
#' keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 5,
#'           verbose = 0, validation_split = 0.2)
#' }
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
Dropout <- function(rate, noise_shape = NULL, seed = NULL, input_shape = NULL) {

  if (!is.null(seed))
    seed <- int32(seed)
  if (!is.null(noise_shape))
    noise_shape <- int32(noise_shape)

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Dropout(rate = rate,
                                             noise_shape = noise_shape,
                                             seed = seed)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Dropout(rate = rate,
                                             noise_shape = noise_shape,
                                             seed = seed,
                                             input_shape = input_shape)
  }

  return(res)
}

#' Flattens the input. Does not affect the batch size.
#'
#' @param input_shape            only need when first layer of a model; sets the input shape
#'                               of the data
#'
#' @examples
#' if (run_examples()) {
#' X_train <- array(rnorm(100 * 28 * 28), dim = c(100, 28, 28, 1))
#' Y_train <- to_categorical(matrix(sample(0:2, 100, TRUE), ncol = 1), 3)
#'
#' mod <- Sequential()
#' mod$add(Conv2D(filters = 2, kernel_size = c(2, 2),
#'                input_shape = c(28, 28, 1)))
#' mod$add(Activation("relu"))
#' mod$add(MaxPooling2D(pool_size=c(2, 2)))
#' mod$add(LocallyConnected2D(filters = 2, kernel_size = c(2, 2)))
#' mod$add(Activation("relu"))
#' mod$add(MaxPooling2D(pool_size=c(2, 2)))
#' mod$add(Dropout(0.25))
#'
#' mod$add(Flatten())
#' mod$add(Dropout(0.5))
#' mod$add(Dense(3, activation='softmax'))
#'
#' keras_compile(mod, loss='categorical_crossentropy', optimizer=RMSprop())
#' keras_fit(mod, X_train, Y_train, verbose = 0)
#' }
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
Flatten <- function(input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Flatten()
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Flatten(input_shape = input_shape)
  }

  return(res)
}

#' Reshapes an output to a certain shape.
#'
#' @param target_shape    target shape. Tuple of integers, does not include
#'                        the samples dimension (batch size).
#' @param input_shape     only need when first layer of a model; sets the input shape
#'                               of the data
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
Reshape <- function(target_shape, input_shape = NULL) {
  target_shape <- sapply(target_shape, list)
  target_shape <- modules$builtin$tuple(int32(target_shape))

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Reshape(target_shape = target_shape)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Reshape(target_shape = target_shape,
                                             input_shape = input_shape)
  }

  return(res)
}

#' Permutes the dimensions of the input according to a given pattern.
#'
#' @param dims              vector of integers. Permutation pattern, does not include the
#'                          samples dimension. Indexing starts at 1.
#' @param input_shape       only need when first layer of a model; sets the input shape
#'                          of the data
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
Permute <- function(dims, input_shape = NULL) {
  dims <- sapply(dims, list)
  dims <- modules$builtin$tuple(int32(dims))

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Permute(dims = dims)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Permute(dims = dims,
                                             input_shape = input_shape)
  }

  return(res)
}

#' Repeats the input n times.
#'
#' @param n               integer, repetition factor.
#' @param input_shape     only need when first layer of a model; sets the input shape
#'                               of the data
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
RepeatVector <- function(n, input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Dropout(n = int32(n))
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Dropout(n = int32(n),
                  input_shape = input_shape)
  }

  return(res)
}

#' Layer that applies an update to the cost function based input activity.
#'
#' @param l1            L1 regularization factor (positive float).
#' @param l2            L2 regularization factor (positive float).
#' @param input_shape   only need when first layer of a model; sets the input shape
#'                        of the data
#' @examples
#' if (run_examples()) {
#' X_train <- matrix(rnorm(100 * 10), nrow = 100)
#' Y_train <- to_categorical(matrix(sample(0:2, 100, TRUE), ncol = 1), 3)
#'
#' mod <- Sequential()
#' mod$add(Dense(units = 50, input_shape = dim(X_train)[2]))
#' mod$add(Dropout(rate = 0.5))
#' mod$add(Activation("relu"))
#' mod$add(Dense(units = 3))
#' mod$add(ActivityRegularization(l1 = 1))
#' mod$add(Activation("softmax"))
#' keras_compile(mod,  loss = 'categorical_crossentropy', optimizer = RMSprop())
#'
#' keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 5,
#'           verbose = 0, validation_split = 0.2)
#' }
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#' @export
ActivityRegularization <- function(l1 = 0.0, l2 = 0.0, input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$ActivityRegularization(l1 = l1, l2 = l2)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$ActivityRegularization(l1 = l1, l2 = l2,
                                             input_shape = input_shape)
  }

  return(res)
}

#' Masks a sequence by using a mask value to skip timesteps.
#'
#' For each timestep in the input tensor (dimension #1 in the tensor),
#' if all values in the input tensor at that timestep
#' are equal to `mask_value`, then the timestep will be masked (skipped)
#' in all downstream layers (as long as they support masking).
#' If any downstream layer does not support masking yet receives such
#' an input mask, an exception will be raised.
#'
#' @param mask_value             the value to use in the masking
#' @param input_shape            only need when first layer of a model; sets the input shape
#'                               of the data
#' @author Taylor B. Arnold, \email{taylor.arnold@@acm.org}
#' @references
#'
#'   Chollet, Francois. 2015. \href{https://keras.io/}{Keras: Deep Learning library for Theano and TensorFlow}.
#'
#'@export
Masking <- function(mask_value, input_shape = NULL) {

  # Need special logic for input_shape because it is passed
  # via kwargs and needs to be manually adjusted
  if (is.null(input_shape)) {
    res <- modules$keras.layers.core$Masking(mask_value = mask_value)
  } else {

    input_shape <- sapply(input_shape, list)
    input_shape <- modules$builtin$tuple(int32(input_shape))

    res <- modules$keras.layers.core$Masking(mask_value = mask_value,
                                             input_shape = input_shape)
  }

  return(res)
}



