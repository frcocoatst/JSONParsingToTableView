//
//  ViewController.swift
//  CellBasedTableView
//
//  Created by Debasis Das on 5/15/17.
//  Copyright © 2017 Knowstack. All rights reserved.
//

//Cell based NSTableView using datasource.
import Cocoa

struct Country : Decodable {
    let name : String
    let capital : String
    let region : String
}


class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource  {
    
    @IBOutlet weak var tableView:NSTableView!
    
    var countries = [Country]()
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        // return count
        return self.countries.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
    
         if (tableColumn?.identifier)!.rawValue == "name" {
            return self.countries[row].name
         }
         else
            if (tableColumn?.identifier)!.rawValue == "capital" {
                return self.countries[row].capital
        }
        else
        {
            return self.countries[row].region
        }
        
        // simplified :
        // return  self.countries[row].name
    }
    
    func parseJSON() {
        
        let jsonURL = "https://restcountries.eu/rest/v2/all"
        
        guard let url = URL(string: jsonURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check err
            // check status 200 OK
            
            do {
                
                self.countries = try JSONDecoder().decode([Country].self, from: data!)
                
                for eachCountry in self.countries {
                    print(eachCountry.name + " : " + eachCountry.capital)
                }
                
            }
            catch {
                print("Error")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            }.resume()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self // as? NSTableViewDelegate
        self.tableView.dataSource = self
        
        //
        parseJSON()
        
    }
}


