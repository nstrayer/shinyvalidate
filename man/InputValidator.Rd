% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validator.R
\name{InputValidator}
\alias{InputValidator}
\title{Shiny validation object}
\description{
An R6 class for adding realtime input validation to Shiny apps.

\code{InputValidator} objects are designed to be created as local variables in
Shiny server functions and Shiny module server functions. The Shiny app
author can register zero, one, or multiple validation rules for each input
field in their UI, using the \code{InputValidator$add_rule()} method.

Once an \code{InputValidator} object is created and populated with rules, it can
be used in a few ways:
\enumerate{
\item The \code{InputValidator$enable()} method can be called to display real-time
feedback to users about what inputs are failing validation, and why.
\item The \code{InputValidator$is_valid()} method returns \code{TRUE} if and only if all
of the validation rules are passing; this can be checked before
executing actions that depend on the inputs being valid.
\item The \code{InputValidator$validate()} method is a lower-level feature that
directly returns information about what fields failed validation, and
why.
}

It's possible to have multiple \code{InputValidator} objects for each Shiny app.
One scenario where this makes sense is if an app contains multiple forms
that are completely unrelated to each other; each form would have its own
\code{InputValidator} instance with a distinct set of rules.
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{InputValidator$new()}}
\item \href{#method-parent}{\code{InputValidator$parent()}}
\item \href{#method-condition}{\code{InputValidator$condition()}}
\item \href{#method-add_validator}{\code{InputValidator$add_validator()}}
\item \href{#method-add_rule}{\code{InputValidator$add_rule()}}
\item \href{#method-enable}{\code{InputValidator$enable()}}
\item \href{#method-disable}{\code{InputValidator$disable()}}
\item \href{#method-fields}{\code{InputValidator$fields()}}
\item \href{#method-is_valid}{\code{InputValidator$is_valid()}}
\item \href{#method-validate}{\code{InputValidator$validate()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
Create a new validator object.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$new(
  priority = 1000,
  session = shiny::getDefaultReactiveDomain()
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{priority}}{When a validator object is enabled, it creates an
internal \code{\link[shiny:observe]{shiny::observe()}} to keep validation feedback in the UI
up-to-date. This parameter controls the priority of that observer. It's
highly recommended to keep this value higher than the priorities of any
observers that do actual work, so users see validation updates quickly.}

\item{\code{session}}{The Shiny \code{session} object. (You should probably just use
the default.)}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-parent"></a>}}
\if{latex}{\out{\hypertarget{method-parent}{}}}
\subsection{Method \code{parent()}}{
For internal use only.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$parent(validator)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{validator}}{An \code{InputValidator} object.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-condition"></a>}}
\if{latex}{\out{\hypertarget{method-condition}{}}}
\subsection{Method \code{condition()}}{
Gets or sets a condition that overrides all of the rules in
this validator. Before performing validation, this validator will
execute the \code{cond} function. If \code{cond} returns \code{TRUE}, then
validation continues as normal; if \code{FALSE}, then the validation rules
will be skipped and treated as if they are all passing.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$condition(cond)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{cond}}{If this argument is missing, then the method returns the
currently set condition function. If not missing, then \code{cond} must
be either a zero-argument function that returns \code{TRUE} or \code{FALSE}; a
single-sided formula that results in \code{TRUE} or \code{FALSE}; or \code{NULL}
(which is equivalent to \code{~ TRUE}).}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
If \code{cond} is missing, then either \code{NULL} or a zero-argument
function; if \code{cond} is provided, then nothing of consequence is
returned.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-add_validator"></a>}}
\if{latex}{\out{\hypertarget{method-add_validator}{}}}
\subsection{Method \code{add_validator()}}{
Add another \code{InputValidator} object to this one, as a
"child". Any time this validator object is asked for its validity, it
will only return \code{TRUE} if all of its child validators are also valid;
and when this validator object is enabled (or disabled), then all of
its child validators are enabled (or disabled) as well.

This is intended to help with validating Shiny modules. Each module can
create its own \code{InputValidator} object and populate it with rules, then
return that object to the caller.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$add_validator(validator)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{validator}}{An \code{InputValidator} object.}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-add_rule"></a>}}
\if{latex}{\out{\hypertarget{method-add_rule}{}}}
\subsection{Method \code{add_rule()}}{
Add an input validation rule. Each input validation rule
applies to a single input. You can add multiple validation rules for a
single input, by calling \code{add_rules()} multiple times; the first
validation rule for an input that fails will be used, and will prevent
subsequent rules for that input from executing.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$add_rule(
  inputId,
  rule,
  ...,
  session. = shiny::getDefaultReactiveDomain()
)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{inputId}}{A single-element character vector indicating the ID of the
input that this rule applies to. (Note that this name should \emph{not} be
qualified by a module namespace; e.g. pass \code{"x"} and not
\code{session$ns("x")}.)}

\item{\code{rule}}{A function that takes (at least) one argument: the input's
value. The function should return \code{NULL} if it passes validation, and
if not, a single-element character vector containing an error message
to display to the user near the input. You can alternatively provide a
single-sided formula instead of a function, using \code{.} as the variable
name for the input value being validated.}

\item{\code{...}}{Optional: Additional arguments to pass to the \code{rule} function
whenever it is invoked.}

\item{\code{session.}}{The session object to which the input belongs. (There's
almost never a reason to change this from the default.)}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-enable"></a>}}
\if{latex}{\out{\hypertarget{method-enable}{}}}
\subsection{Method \code{enable()}}{
Begin displaying input validation feedback in the user
interface. Once enabled, this validator object will automatically keep
the feedback up-to-date. (It's safe to call the \code{enable()} method
on an already-enabled validator.) If this validator object has been
added to another validator object using \code{InputValidator$add_validator},
calls to \code{enable()} on this validator will be ignored.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$enable()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-disable"></a>}}
\if{latex}{\out{\hypertarget{method-disable}{}}}
\subsection{Method \code{disable()}}{
Clear existing input validation feedback in the user
interface for all inputs represented in this validator's ruleset, and
stop providing feedback going forward. Once disabled, \code{enable()} can be
called to resume input validation.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$disable()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-fields"></a>}}
\if{latex}{\out{\hypertarget{method-fields}{}}}
\subsection{Method \code{fields()}}{
Returns \code{TRUE} if all input validation rules currently pass,
\code{FALSE} if not.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$fields()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-is_valid"></a>}}
\if{latex}{\out{\hypertarget{method-is_valid}{}}}
\subsection{Method \code{is_valid()}}{
Returns \code{TRUE} if all input validation rules currently pass,
\code{FALSE} if not.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$is_valid()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-validate"></a>}}
\if{latex}{\out{\hypertarget{method-validate}{}}}
\subsection{Method \code{validate()}}{
Run validation rules and gather results. For advanced usage
only; most apps should use the \code{is_valid()} and \code{enable()} methods
instead. The return value of this method is a named list, where the
names are (fully namespace qualified) input IDs, and the values are
either \code{NULL} (if the input value is passing) or a single-element
character vector describing a validation problem.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{InputValidator$validate()}\if{html}{\out{</div>}}
}

}
}
