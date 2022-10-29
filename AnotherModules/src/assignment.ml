let add a b = failwith "TODO add"

let filter p xs = failwith "TODO filter"

let starts_with haystack hay = failwith "TODO starts_with"

module type Field = sig
  type t
  val zero : t                  (* zero element of the field *)
  val one : t                   (* unit element of the field *)
  val compare : t -> t -> int   (* comparison *)
  val to_string : t -> string   (* field element to string *)
  val add : t -> t -> t         (* addition *)
  val mul : t -> t -> t         (* multiplication *)
  val sub : t -> t -> t         (* subtraction *)
  val div : t -> t -> t         (* division *)
  val add_inv : t -> t          (* additive inverse *) 
  val mul_inv : t -> t          (* multiplicative inverse *)
end

module type RationalField =
sig
  include Field with type t = int * int
  type t = int * int          (* rationals are represented as pairs of int *)
  exception Bad_rational of string
  val standard_form : t -> t  (* standard from of a rational number *)
  val to_float : t -> float   (* decimal expansion *)
  val from_int : int -> t     (* integer to rational conversion *)          
end

module type GaussianRationalField =
sig
  include Field with type t = (int * int) * (int * int)
    (* Gaussian rationals are represented as pairs of rationals *)
  exception Division_by_zero of string
  val from_rational : (int * int ) -> t   (* rational to complex *)     
  val conj : t -> t                       (* conjugate *)
  val re : t -> (int * int)               (* real part *)
  val im : t -> (int * int)               (* imaginary part *)
end

module Rationals : RationalField with type t = int * int = 
struct
  type t = int * int
  exception Bad_rational of string 

  let zero = (0,1)

  let one = (1,1)

  let standard_form (n,d) =
    let rec FindGCD a b = 
      if(a != 0 && b != 0) then
        if(a > b) then FindGCD (a mod b) b
        else FindGCD a (b mod a)
      else if (a = 0) then b
      else a in
    let MinusChecker = if((n < 0 && d < 0) || (n > 0 && d > 0)) then 1
      else -1 in
    let abs n = 
      if(n < 0) then -n
      else n in
    let nAbs = abs n in
    let dAbs = abs d in
    if(n = 0) then (n, d)
    else if (d = 0) then raise raise (Bad_rational "nwnwnwnwnwnwnwnwnwnw")
    else if (MinusChecker = 1) then (n / (FindGCD nAbs dAbs), d / (FindGCD nAbs dAbs))
    else (-(n / (FindGCD nAbs dAbs)), d / (FindGCD nAbs dAbs))
         

  let compare (r1,i1) (r2,i2) = 
    if (i1 = 0 || i2 = 0) then raise (Bad_rational "nwnwnwnwnwnwnwnwnwnw")
    else compare (standard_form (r1,i1)) (standard_form (r2,i2))

  let to_string (n,d) = 
    let (nStandard,dStandard) = standard_form (n,d) in 
    if dStandard = 1 then (string_of_int n) 
    else if nStandard = 0 then "0"
    else (string_of_int nStandard)^"/"^(string_of_int dStandard)
      
  let add (r1,i1) (r2,i2) = standard_form (r1*i2 + r2*i1, i1*i2)      

  let mul (r1,i1) (r2,i2) = standard_form (r1*r2, i1*i2)

  let sub (r1,i1) (r2,i2) = standard_form (r1*i2 - r2*i1, i1*i2)

  let div (r1,i1) (r2,i2) = standard_form (r1*i2, r2*i1)

  let add_inv (n,d) = 
    if d = 0 then raise (Bad_rational "nwnwnwnwnwnwnwnwnwnw")
    else(-n, d)

  let mul_inv (n,d) = if d = 0  then raise (Bad_rational "nwnwnwnwnwnwnwnwnwnw")
    else if  n = 0 then raise (Bad_rational "nwnwnwnwnwnwnwnwnwnw")
    else(d, n)

  let to_float (n,d) = if d = 0  then raise (Bad_rational "nwnwnwnwnwnwnwnwnwnw")
    else (float_of_int n)/.(float_of_int d)

  let from_int n = (n, 1)
end  

module GaussianRationals : GaussianRationalField with type t = (int * int) * (int * int) =
struct
  type t = (int * int) * (int * int)
  exception Division_by_zero of string

  let zero = ((0,1),(0,1))

  let one = ((1,1),(0,1))

  let compare (r1,i1) (r2,i2) = if Rationals.compare r1 r2 != 0 then Rationals.compare r1 r2
    else Rationals.compare i1 i2

  let to_string (r,i) = let (rStandard,iStandard) = (Rationals.standard_form r, Rationals.standard_form i) in 
    if (iStandard == (0,1)) then Rationals.to_string rStandard
    else (Rationals.to_string r)^" + i*"^(Rationals.to_string i)

  let add (r1,i1) (r2,i2) = (Rationals.add r1 r2, Rationals.add i1 i2)

  let mul (r1,i1) (r2,i2) = (Rationals.sub (Rationals.mul r1 r2) (Rationals.mul i1 i2), Rationals.add (Rationals.mul r1 i2) (Rationals.mul i1 r2))

  let sub (r1,i1) (r2,i2) = (Rationals.sub r1 r2, Rationals.sub i1 i2)

  let div (r1,i1) (r2,i2) = let rSum = Rationals.add (Rationals.mul r1 r2) (Rationals.mul i1 i2) in 
    let iSub = Rationals.sub (Rationals.mul i1 r2) (Rationals.mul r1 i2) in 
    let q = Rationals.add (Rationals.mul r2 r2) (Rationals.mul i2 i2) in 
    (Rationals.div rSum q, Rationals.div iSub q)

  let add_inv (r,i) = (Rationals.add_inv r, Rationals.add_inv i)

  let mul_inv (r,i) = div ((1,1),(0,1)) (r,i)

  let from_rational r =(r, (0,1))
        
  let conj (r,i) = match r with
    |(_,0) -> raise (Division_by_zero "nwnwnwnwnwnwnwnwnwnw") 
    |_ -> (r, Rationals.add_inv i)

  let re (r,i) = match (r,i) with
    |((_,0), _) -> raise (Division_by_zero "nwnwnwnwnwnwnwnwnwnw") 
    |(_, (_,0)) -> raise (Division_by_zero "nwnwnwnwnwnwnwnwnwnw") 
    |_ -> Rationals.standard_form r

  let im (r,i) = match (r,i) with
    |((_,0), _) -> raise (Division_by_zero "nwnwnwnwnwnwnwnwnwnw") 
    |(_, (_,0)) -> raise (Division_by_zero "nwnwnwnwnwnwnwnwnwnw") 
    |_ -> Rationals.standard_form i
end;;
  
