type country = {
    name: string;
    domain: string;
    language: string;
    id: int;
};;

let brazil = {name = "Brazil"; domain = ".br"; language = "Portuguese"; id = 100 };;

brazil.name;;

brazil.domain;;

brazil.language;;

brazil.id;;

let countries = [
    {name = "Brazil" ; domain = ".br" ; language = "Portuguese" ; id = 100 } ;
    {name = "United Kingdom" ; domain = ".co.uk" ; language = "English" ; id = 10 } ;
    {name = "South Africa" ; domain = ".co.za" ; language = "English" ; id = 40 } ;
    {name = "France" ; domain = ".fr" ; language = "French" ; id = 20 } ;
    {name = "Taiwan ROC" ; domain = ".tw" ; language = "Chinese" ; id = 54 } ;
    {name = "Australia" ; domain = ".au" ; language = "English" ; id = 354 } ;
      ];;

List.map (fun c -> c.name) countries;;

List.map (fun c -> c.domain) countries;;

List.filter (fun c -> c.name = "France") countries;;

List.filter (fun c -> c.language = "English") countries;;

let english_speaking_countries =
countries 
|> List.filter (fun c -> c.language = "English")
|> List.map (fun c -> c.name);;

countries
|> List.filter (fun c -> c.language = "English")
|> List.map (fun c -> c.name, c.domain);;

List.find (fun x -> x.id = 100) countries;;

List.find (fun x -> x.id = 1354) countries;;

countries
|> List.find (fun x -> x.id = 100)
|> fun x -> x.name;;

