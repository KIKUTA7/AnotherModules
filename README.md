# AnotherModules
<div _ngcontent-bkf-c211="" id="programming-exercise-instructions-content" class="guided-tour instructions__content__markdown markdown-preview"><p>Below you can see the definition of three module types: 
   <code>Field</code>, <code>RationalField</code>, and <code>GaussianRationalField</code>. 
   The latter two include and extend the Field type. </p>
<p>Your task is to implement the modules <code>Rationals</code> and GaussianRationals
   that implement the functions defined in these interfaces (and maybe some
   other, local functions as well).</p>
<p>For instance, in the module <code>Rationals</code> one can have the following structure</p>
<pre><code class="hljs">    module Rationals : RationalField =
      struct
        <span class="hljs-keyword">type</span> t = int * int
        exception Bad_rational <span class="hljs-keyword">of</span> <span class="hljs-keyword">string</span>
        let zero = ...
        ...
        let standard_form (n,d) = ...
        <span class="hljs-comment">(* A rational in the standard form has its numerator and denominator
           relatively prime and the denominator is positive 
         *)</span>

        let compare (r1,i1) (r2,i2) = ...
        <span class="hljs-comment">(* Compare two rational numbers as the Ocaml compare function
           would compare two pairs. Make sure that the rationals are brought  
           in the standard form before comparision
         *)</span>
         ...
        <span class="hljs-comment">(* Define add, mul, sub, div operations for rationals,
           define also their additive and multiplicative inverses, 
           raise exeption Bad_rational if denominator becomes zero.

           Define to_float function that gives the decimal expansion of 
           a rational number. Define also from_int function that makes
           a rational out of an integer.
         *)</span>    
      <span class="hljs-keyword">end</span>
</code></pre>
<p>In the module <code>GaussianRationals</code> the structure can be as follows: </p>
<pre><code class="hljs">    module GaussianRationals : GaussianRationalField =
      struct
        <span class="hljs-keyword">type</span> t = (int * int) * (int * int)
        exception Division_by_zero <span class="hljs-keyword">of</span> <span class="hljs-keyword">string</span>
        let zero = ...
        ...
        let compare (r1,i1) (r2,i2) = ...
        <span class="hljs-comment">(* for compare the rationals r1 and r2. If Rationals.compare
           for them does not give 0, then retiurn it. Otherwise
           return the result of Rationals.compare for i1 and i2 
         *)</span>

        let to_string (r,i) = ...
        <span class="hljs-comment">(* make sure that both the real part r and the imaginary part i
           are in standard form as a rational number. 
           Skip a summand if it is 0. 
         *)</span>

        let from_rational r =
          <span class="hljs-comment">(* Make a Gaussaan rational from a rational number by putting
             the rational as the real part of the Gaussian rational.
           *)</span>
          ...
        <span class="hljs-comment">(* Define add, mul, sub, div operations for Gaussian rationals,
           define also their additive and multiplicative inverses, raise
           the expeption Division_by_zero if necessary.

           Define the function re (for the real part of a Gaussian
           rational, im (for the imaginary part) and conj (for the conjugate) 
         *)</span>    
       <span class="hljs-keyword">end</span>
</code></pre>
<p>The operations <code>add</code>, <code>mul</code>, <code>sub</code>, <code>div</code> correspond respectively to <code>addition</code>, 
   <code>multiplication</code>, <code>subtraction</code> and <code>division</code> in the corresponding field.
   For module <code>Rationals</code> they are defined as the corresponding operations
   for rational numbers. Make sure that the results of all operations are
   returned in the strandard form, which means that the number should be 
   transformed so that the numerator and the denominator are relatively prime, 
   and the denominator is always positive.</p>
<p>Gaussian rationals are complex numbers with rational coefficients.<br>
   Hence, <code>add</code>, <code>mul</code>, <code>sub</code>, and <code>div</code> are <code>addition</code>, <code>multiplication</code>, <code>subtraction</code> 
   and <code>division</code> operations are those for complex numbers, where the elementary 
   operations are perfomed over rationals (for this, you can use the operations 
   defined in the module Rationals).</p>
<p>In <code>to_string</code> function, return a string that correspond to the standard form 
   of a rational number and, besides, for numbers with the denominator 1 return 
   only the string form  of the numerator; for number with the numerator 0 
   return <code>0</code>; Skip a <code>summand</code> if it is <code>0</code>.</p>
<p>WRITE YOUR IMPLEMENTATION BELOW, AFTER THE DEFINITIONS OF THE SIGNATURES.</p>
<pre><code class="hljs">module <span class="hljs-keyword">type</span> Field = sig
  <span class="hljs-keyword">type</span> t
  val zero : t                  <span class="hljs-comment">(* zero element of the field *)</span>
  val one : t                   <span class="hljs-comment">(* unit element of the field *)</span>
  val compare : t -&gt; t -&gt; int   <span class="hljs-comment">(* comparison *)</span>
  val to_string : t -&gt; <span class="hljs-keyword">string</span>   <span class="hljs-comment">(* field element to string *)</span>
  val add : t -&gt; t -&gt; t         <span class="hljs-comment">(* addition *)</span>
  val mul : t -&gt; t -&gt; t         <span class="hljs-comment">(* multiplication *)</span>
  val sub : t -&gt; t -&gt; t         <span class="hljs-comment">(* subtraction *)</span>
  val <span class="hljs-keyword">div</span> : t -&gt; t -&gt; t         <span class="hljs-comment">(* division *)</span>
  val add_inv : t -&gt; t          <span class="hljs-comment">(* additive inverse *)</span> 
  val mul_inv : t -&gt; t          <span class="hljs-comment">(* multiplicative inverse *)</span>
<span class="hljs-keyword">end</span>
</code></pre>
<pre><code class="hljs">module <span class="hljs-keyword">type</span> RationalField =
  sig
    include Field <span class="hljs-keyword">with</span> <span class="hljs-keyword">type</span> t = int * int
    <span class="hljs-keyword">type</span> t = int * int          <span class="hljs-comment">(* rationals are represented as pairs of int *)</span>
    exception Bad_rational <span class="hljs-keyword">of</span> <span class="hljs-keyword">string</span>
    val standard_form : t -&gt; t  <span class="hljs-comment">(* standard from of a rational number *)</span>
    val to_float : t -&gt; float   <span class="hljs-comment">(* decimal expansion *)</span>
    val from_int : int -&gt; t     <span class="hljs-comment">(* integer to rational conversion *)</span>          
  <span class="hljs-keyword">end</span>
</code></pre>
<pre><code class="hljs">module <span class="hljs-keyword">type</span> GaussianRationalField =
  sig
    include Field <span class="hljs-keyword">with</span> <span class="hljs-keyword">type</span> t = (int * int) * (int * int)
    <span class="hljs-comment">(* Gaussian rationals are represented as pairs of rationals *)</span>
    exception Division_by_zero <span class="hljs-keyword">of</span> <span class="hljs-keyword">string</span>
    val from_rational : (int * int ) -&gt; t   <span class="hljs-comment">(* rational to complex *)</span>     
    val conj : t -&gt; t                       <span class="hljs-comment">(* conjugate *)</span>
    val re : t -&gt; (int * int)               <span class="hljs-comment">(* real part *)</span>
    val im : t -&gt; (int * int)               <span class="hljs-comment">(* imaginary part *)</span>
  <span class="hljs-keyword">end</span>
</code></pre>
<h5 id="sometests">some tests:</h5>
<pre><code class="hljs"> Rationals.zero = (<span class="hljs-number">0</span>,<span class="hljs-number">1</span>)<span class="hljs-comment">;;</span>
 Rationals.one = (<span class="hljs-number">1</span>,<span class="hljs-number">1</span>)<span class="hljs-comment">;;</span>
 Rationals.standard_form (<span class="hljs-number">6</span>, -<span class="hljs-number">15</span>) = (-<span class="hljs-number">2</span>,<span class="hljs-number">5</span>)<span class="hljs-comment">;;</span>
 Rationals.compare (<span class="hljs-number">3</span>,-<span class="hljs-number">5</span>) (<span class="hljs-number">5</span>,<span class="hljs-number">3</span>) = -<span class="hljs-number">1</span><span class="hljs-comment">;;</span>
 Rationals.<span class="hljs-keyword">add </span>(<span class="hljs-number">2</span>,<span class="hljs-number">4</span>) (<span class="hljs-number">3</span>,<span class="hljs-number">6</span>) = (<span class="hljs-number">1</span>,<span class="hljs-number">1</span>)<span class="hljs-comment">;;</span>
 Rationals.<span class="hljs-keyword">mul </span>(<span class="hljs-number">2</span>,<span class="hljs-number">4</span>) (<span class="hljs-number">3</span>,<span class="hljs-number">6</span>) = (<span class="hljs-number">1</span>,<span class="hljs-number">4</span>)<span class="hljs-comment">;;</span>
 Rationals.<span class="hljs-keyword">sub </span>(-<span class="hljs-number">2</span>,<span class="hljs-number">4</span>) (<span class="hljs-number">7</span>,<span class="hljs-number">3</span>) = (-<span class="hljs-number">17</span>,<span class="hljs-number">6</span>)<span class="hljs-comment">;;</span>
 Rationals.<span class="hljs-keyword">div </span>(-<span class="hljs-number">2</span>,<span class="hljs-number">4</span>) (<span class="hljs-number">7</span>,<span class="hljs-number">3</span>) = (-<span class="hljs-number">3</span>,<span class="hljs-number">14</span>)<span class="hljs-comment">;;</span>
 (try Some (Rationals.<span class="hljs-keyword">div </span>(<span class="hljs-number">1</span>,<span class="hljs-number">2</span>) (<span class="hljs-number">0</span>,<span class="hljs-number">5</span>)) with Rationals.<span class="hljs-keyword">Bad_rational </span>_ -&gt; None) = None<span class="hljs-comment">;;</span>
 Rationals.<span class="hljs-keyword">mul </span>(<span class="hljs-number">1</span>,-<span class="hljs-number">3</span>) Rationals.zero = Rationals.zero<span class="hljs-comment">;;</span>
 Rationals.to_float (<span class="hljs-number">6</span>,<span class="hljs-number">8</span>) = <span class="hljs-number">0</span>.<span class="hljs-number">75</span><span class="hljs-comment">;;</span>


 GaussianRationals.zero = ((<span class="hljs-number">0</span>, <span class="hljs-number">1</span>), (<span class="hljs-number">0</span>, <span class="hljs-number">1</span>))<span class="hljs-comment">;;</span>
 GaussianRationals.one = ((<span class="hljs-number">1</span>, <span class="hljs-number">1</span>), (<span class="hljs-number">0</span>, <span class="hljs-number">1</span>))<span class="hljs-comment">;;</span>
 GaussianRationals.<span class="hljs-keyword">mul((2,4),(7,-2)) </span>((<span class="hljs-number">3</span>,<span class="hljs-number">6</span>),(<span class="hljs-number">7</span>,<span class="hljs-number">2</span>)) = ((<span class="hljs-number">25</span>, <span class="hljs-number">2</span>), (<span class="hljs-number">0</span>, <span class="hljs-number">1</span>))<span class="hljs-comment">;;</span>
 GaussianRationals.<span class="hljs-keyword">add_inv </span>((<span class="hljs-number">6</span>,<span class="hljs-number">15</span>), (<span class="hljs-number">7</span>,<span class="hljs-number">21</span>)) = ((-<span class="hljs-number">2</span>,<span class="hljs-number">5</span>),(-<span class="hljs-number">1</span>,<span class="hljs-number">3</span>))<span class="hljs-comment">;;</span>
 GaussianRationals.<span class="hljs-keyword">mul_inv </span>((<span class="hljs-number">8</span>,<span class="hljs-number">16</span>),(<span class="hljs-number">3</span>,<span class="hljs-number">7</span>)) = ((<span class="hljs-number">98</span>, <span class="hljs-number">85</span>), (-<span class="hljs-number">84</span>, <span class="hljs-number">85</span>))<span class="hljs-comment">;;</span>
 GaussianRationals.to_string ((<span class="hljs-number">2</span>,-<span class="hljs-number">4</span>),(<span class="hljs-number">4</span>,-<span class="hljs-number">5</span>)) = <span class="hljs-string">"-1/2-4/5*I"</span><span class="hljs-comment">;;</span>
 GaussianRationals.re ((<span class="hljs-number">6</span>, <span class="hljs-number">9</span>), (<span class="hljs-number">0</span>, <span class="hljs-number">1</span>)) = (<span class="hljs-number">2</span>, <span class="hljs-number">3</span>)<span class="hljs-comment">;;</span>
 GaussianRationals.im ((<span class="hljs-number">6</span>, <span class="hljs-number">9</span>), (<span class="hljs-number">2</span>, <span class="hljs-number">4</span>)) = (<span class="hljs-number">1</span>, <span class="hljs-number">2</span>)<span class="hljs-comment">;;</span>
 GaussianRationals.conj ((<span class="hljs-number">2</span>, <span class="hljs-number">3</span>), (<span class="hljs-number">0</span>, <span class="hljs-number">1</span>)) = ((<span class="hljs-number">2</span>, <span class="hljs-number">3</span>), (<span class="hljs-number">0</span>, <span class="hljs-number">1</span>))<span class="hljs-comment">;;</span>
</code></pre></div>
