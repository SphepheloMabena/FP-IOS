
import UIKit
import SwiftQRScanner
import Firebase
import SQLite3
import Network
//developed by Sphephelo Mabena
var check:Int=0;
var hour:Int=0;
var minutes:Int=0;
var day:Int=0;
var month:Int=0;
var year:Int=0;
var veenue="";
var db: OpaquePointer?
//developed by Sphephelo Mabena
class ViewController: UIViewController {
    //developed by Sphephelo Mabena
   var db: OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hola")
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
            } else {
                print("No connection.")
                let story=UIStoryboard(name: "Main",bundle :nil);
                let controller=story.instantiateViewController(withIdentifier: "NoInternet") as! NoInternet;
                self.present(controller, animated: true, completion: nil)
            }
//developed by Sphephelo Mabena
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
           let queue = DispatchQueue(label: "Monitor")
           monitor.start(queue: queue)
        }
        //the database file
        //creating databas for parking ticket
               
        
        print("Minutes \(minutes)")
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    @objc func functionHere()
    {
        print("Timer workss")
    }
    override func viewDidAppear(_ animated: Bool) {
    
        print("Hellow")
        if (check == 1)
        {
            ScanQRPage();
            check=1;
        }
        else if(check == 2)
        {
            invalidQRPage();
            check=2;
        }
        //reasearch on how to navigate programatically to another page
    }
    
    func ScanQRPage()
    {
        let story=UIStoryboard(name: "Main", bundle: nil);
        let controller=story.instantiateViewController(withIdentifier: "Parkingticket") as! Parkingticket;
        self.present(controller, animated: true, completion:nil);
    }
    func invalidQRPage()
    {
        let story=UIStoryboard(name: "Main", bundle: nil);
        let controller=story.instantiateViewController(withIdentifier: "InvalidQRCode") as! InvalidQRCode;
        self.present(controller, animated: true, completion:nil);
        check=2;
    }

    @IBAction func scanQRCode(_ sender: Any) {
        
        //QRCode scanner without Camera switch and Torch
        //let scanner = QRCodeScannerController()
        
        //QRCode with Camera switch and Torch
        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//var window: UIWindow?

extension ViewController: QRScannerCodeDelegate {
    
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        var encrypt=Encryptor();
        encrypt.Decrypt(etext: result)
        var scannedResult:String=encrypt.Decrypt(etext: result);
        
        var resultArray:[String]=[String(Array(scannedResult))];
        
        print("First letter : \(Array(scannedResult)[0])")
        print("Second letter : \(Array(scannedResult)[1])")
        
        
        
        if(Array(scannedResult)[0]=="f" && Array(scannedResult)[1]=="p")
        {
            print("This is a fp qrcode")
            
            if(scannedResult.split(separator: "x").count < 3)
            {
                //this is the fp entrance qr code
                check=1;
            }
            else
            {
                //this is not the fp entrance qr code
                check=2;
            }
            
            veenue=String(scannedResult.split(separator: "x")[1]);
            
        }
        else
        {
            print("This is not a fp qrcode")
            check=2;
            
        }
        
        print("result:\(encrypt.Decrypt(etext: result))")
        
        //developed by Sphephelo Mabena
        
        
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("error:\(error)")
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}
//developed by Sphephelo Mabena
class NoInternet: UIViewController {
 

 override func viewDidLoad() {
     super.viewDidLoad()
    let monitor = NWPathMonitor()
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            print("We're connected!")
            
            if(check == 0)
            {
                let story=UIStoryboard(name: "Main",bundle :nil);
                let controller=story.instantiateViewController(withIdentifier: "ViewController") as! ViewController;
                self.present(controller, animated: true, completion: nil)
                
            }
            else if(check == 2)
            {
                let story=UIStoryboard(name: "Main",bundle :nil);
                let controller=story.instantiateViewController(withIdentifier: "ParkingTicket") as! Parkingticket;
                self.present(controller, animated: true, completion: nil)
            }
            else if(check==4)
            {
               
            }
            else if(check==6)
            {
                
            }
        } else {
            print("No connection.")
            
        }

        print(path.isExpensive)
    }
    let queue = DispatchQueue(label: "Monitor")
    monitor.start(queue: queue)
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
       let queue = DispatchQueue(label: "Monitor")
       monitor.start(queue: queue)
    }
    }
}

//developed by Sphephelo Mabena
class Encryptor
{
    
    var e0:String="egsxgec$r";
    var e1:String="mjsvx$$$r";
    var e2:String="#d4%78vxr";
    var e3:String="#3#3#3#3r";
    var e4:String="@[@[@[@[r";//never use "r" here
    var e5:String="gcp{g}%%r";
    var e6:String="btbtbtbtr";
    var e7:String="vbs#d:ucr";
    var e8:String="mythzllor";
    var e9:String="8043gx#r";
    var edash:String="hfxv55$7r";
    var eHash:String="bvcr##r";
    var ea:String="zx48ed2dr";//ea means equals a
    var eb:String="jn9u4fqxr";
    var ec:String="vbn877z%r";
    var ed:String="w98xjh3?r";
    var ee:String="#mxhkndtr";
    var ef:String="9dnj9d%ur";
    var eg:String="ikzh@!0$r";
    var eh:String="ut^hs$jxr";
    var ei:String="?mx>}+8fr";
    var ej:String="*w#&^@9qr";
    var ek:String="k.fe@$xwr";//all of these will end with a r
    var el:String="h:ms-#9@r";
    var em:String="*bv<t^&7r";
    var en:String="mnwq&j)nr";
    var eo:String="nU9%?@k%r";
    var ep:String="#vb&jhobr";
    var eq:String="bhc@4:jir";
    var er:String="#b/f@e&#r";//changed \ to / please update on other devices
    var es:String="#bcgxs%tr";
    var et:String="&vhx4mnjr";
    var eu:String="%cf%cf%hr";
    var ev:String="zvchuebpr";
    var ew:String="xcexeubzr";
    var ex:String="xz#hb%hor";
    var ey:String="#jdbx#j8r";
    var ez:String="$hf%#@88r";
    var whitenode:String="a#r";
    
    var a:String="a";
    var b:String="b";
    var c:String="c";
    var d:String="d";
    var e:String="e";
    var f:String="f";
    var g:String="g";
    var h:String="h";
    var i:String="i";
    var j:String="j";
    var k:String="k";
    var l:String="l";
    var m:String="m";
    var n:String="n";
    var o:String="o";
    var p:String="p";
    var q:String="q";
    var r:String="r";
    var s:String="s";
    var t:String="t";
    var u:String="u";
    var v:String="v";
    var w:String="w";
    var xx:String="x";
    var y:String="y";
    var z:String="z";


    
    func Encrypt(word:String)-> String
    {
        
        var text :String=word.lowercased();
        var intArray=[Int]();
        
        for n in 1...text.count
        {
            var chart:Int=n-1;
           
            
            intArray.append(chart);
            
        }
        
        var encrypted:String="";
        
        for x in intArray
        {
            switch(Array(text)[x])
            {
            case " ":
                encrypted+=whitenode;
            break;
            
            case "0":
                encrypted+=e0;
            break;
            
            case "1":
                encrypted+=e1;
            break;
            
            case "2"://developed by Sphephelo Mabena
                encrypted+=e2;
            break;
            
            case "3":
                encrypted+=e3;
            break;
            
            case "4":
                encrypted+=e4;
            break;
            
            case "5":
                encrypted+=e6;
            break;
            
            case "6":
                encrypted+=e7;
            break;
            
            case "7":
                encrypted+=e7;
            break;
            
            case "8":
                encrypted+=e8;
            break;
            
            case "9":
                encrypted+=e9;
            break;
            
            case "#":
                encrypted+=eHash;
            break;
            
            case "a":
                encrypted+=ea;
            break;
            
            case "b":
                encrypted+=eb;
            break;
            
            case "c":
                encrypted+=ec;
            break;
            
            case "d":
                encrypted+=ed;
            break;
            
            case "e":
                encrypted+=ee;
            break;
            
            case "f":
                encrypted+=ef;
            break;
            
            case "g":
                encrypted+=eg;
            break;
            
            case "h":
                encrypted+=eh;
            break;
            
            case "i":
                encrypted+=ei;
            break;
            
            case "j":
                encrypted+=ej;
            break;
            
            case "k":
                encrypted+=ek;
            break;
            
            case "l":
                encrypted+=el;
            break;
            
            case "m":
                encrypted+=em;
            break;
            
            case "n":
                encrypted+=en;
            break;
            
            case "o":
                encrypted+=eo;
            break;
            
            case "p":
                encrypted+=ep;
            break;
            
            case "q":
                encrypted+=eq;
            break;
            
            case "r":
                encrypted+=er;
            break;
            
            case "s":
                encrypted+=es;
            break;
            
            case "t":
                encrypted+=et;
            break;
            
            case "u":
                encrypted+=eu;
            break;
            
            case "v":
                encrypted+=ev;
            break;
            
            case "w":
                encrypted+=ew;
            break;
            
            case "x":
                encrypted+=ex;
            break;
            
            case "y":
                encrypted+=ey;
            break;
            
            case "z":
                encrypted+=ez;
            break;
            
            default:
                encrypted="Error";
            }
            
            
        }
        
        
        return encrypted;
    }
    
    
    func Decrypt(etext:String)->String//encrypted text
            {
                var ta=self.ea.split(separator: "r")[0];//test a
                var tb=self.eb.split(separator:"r")[0];//tesa b //these are the testcases
                var tc=self.ec.split(separator:"r")[0];
                var td=self.d.split(separator:"r")[0];
                var te=self.ee.split(separator:"r")[0];
                var tf=self.ef.split(separator:"r")[0];
                var tg=self.eg.split(separator:"r")[0];
                var th=self.eh.split(separator:"r")[0];
                var ti=self.ei.split(separator:"r")[0];
                var tj=self.ej.split(separator:"r")[0];
                var tk=self.ek.split(separator:"r")[0];
                var tl=self.el.split(separator:"r")[0];
                var tm=self.em.split(separator:"r")[0];
                var tn=self.en.split(separator:"r")[0];
                var to=self.eo.split(separator:"r")[0];
                var tp=self.ep.split(separator:"r")[0];
                var tq=self.eq.split(separator:"r")[0];
                var tr=self.er.split(separator:"r")[0];
                var ts=self.es.split(separator:"r")[0];
                var tt=self.et.split(separator:"r")[0];
                var tu=self.eu.split(separator:"r")[0];
                var tv=self.ev.split(separator:"r")[0];
                var tw=self.ew.split(separator:"r")[0];
                var tx=self.ex.split(separator:"r")[0];
                var ty=self.ey.split(separator:"r")[0];
                var tz=self.ez.split(separator:"r")[0];
                var twhite=self.whitenode.split(separator:"r")[0];
                var t1=self.e1.split(separator:"r")[0];
                var t2=self.e2.split(separator:"r")[0];
                var t3=self.e3.split(separator:"r")[0];
                var t4=self.e4.split(separator:"r")[0];
                var t5=self.e5.split(separator:"r")[0];
                var t6=self.e6.split(separator:"r")[0];
                var t7=self.e7.split(separator:"r")[0];
                var t8=self.e8.split(separator:"r")[0];
                var t9=self.e9.split(separator:"r")[0];
                var t0=self.e0.split(separator:"r")[0];
                var tHash=self.eHash.split(separator:"r")[0];
                //developed by Sphephelo Mabena
            
                var size:Int=etext.count/8;
                /*var text:[String]=etext.split(separator: "r");
                
                var text :String=word.lowercased();
                var decryptArr=[String]();*/
                var decryptArr=[String]();
                var decrypted:String="";
                
                
                    //decryptArr.append(String(etext.split(separator: "r")[chart]))//etext.split(separator: "r")[n];
                   
                    
    
                    
                //word to be returned
               
                for x in etext.split(separator: "r")
                {
                    
                    switch(String(x))
                    {
                    case String(twhite):
                        decrypted+=" ";
                    break;
                    
                    case String(t0):
                        decrypted+="0";
                    break;
                    
                    case String(t1):
                        decrypted+="1";
                    break;
                    
                    case String(t2):
                        decrypted+="2";
                    break;
                    //developed by Sphephelo Mabena
                    case String(t3):
                        decrypted+="3";
                    break;
                    
                    case String(t4):
                        decrypted+="4";
                    break;
                    
                    case String(t5):
                        decrypted+="5";
                    break;
                    
                    case String(t6):
                        decrypted+="6";
                    break;
                    
                    case String(t7):
                        decrypted+="7";
                    break;
                    
                    case String(t8):
                        decrypted+="8";
                    break;
                    
                    case String(t9):
                        decrypted+="9"
                    break;
                    
                    case String(tHash):
                        decrypted+="#";
                    break;
                    
                    case String(ta):
                        decrypted+=a;
                    break;
                    
                    case String(tb):
                        decrypted+=b;
                    break;
                    
                    case String(tc):
                        decrypted+=c;
                    break;
                    
                    case String(td):
                        decrypted+=d;
                    break;
                    
                    case String(te):
                        decrypted+=e;
                    break;
                    
                    case String(tf):
                        decrypted+=f;
                    break;
                   //developed by Sphephelo Mabena
                    case String(tg):
                        decrypted+=g;
                    break;
                    
                    case String(th):
                        decrypted+=h;
                    break;
                    
                    case String(ti):
                        decrypted+=i;
                    break;
                    
                    case String(tj):
                        decrypted+=j;
                    break;
                    
                    case String(tk):
                        decrypted+=k;
                    break;
                    
                    case String(tl):
                        decrypted+=l;
                    break;
                    
                    case String(tm):
                        decrypted+=m;
                    break;
                    
                    case String(tn):
                        decrypted+="n";
                    break;
                    
                    case String(to):
                        decrypted+=o;
                    break;
                    
                    case String(tp):
                        decrypted+=p;
                    break;
                    //developed by Sphephelo Mabena
                    case String(tq):
                        decrypted+=q;
                    break;
                    
                    case String(tr):
                        decrypted+=r;
                    break;
                    
                    case String(ts):
                        decrypted+=s;
                    break;
                    
                    case String(tt):
                        decrypted+=t;
                    break;
                    
                    case String(tu):
                        decrypted+=u;
                    break;
                    
                    case String(tv):
                        decrypted+=v;
                    break;
                    
                    case String(tw):
                        decrypted+=w;
                    break;
                    
                    case String(tx):
                        decrypted+="x";
                    break;
                    
                    case String(ty):
                        decrypted+=y;
                    break;
                    
                    case String(tz):
                        decrypted+=z;
                    break;
                    
                    default:
                        decrypted="Error"
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                //the following code convert the first character to upercase
               /* String decryption[]=decrypted.split("");
                decryption[0]=decryption[0].toUpperCase();
                String fdecryption="";
                
                for (int ko=0;ko<decryption.length;ko++)
                {
                    fdecryption +=decryption[ko];
                    
                }*/
                
            
                
                
                return decrypted;
            }
        
    
}

class Parkingticket:UIViewController {


    
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var venue: UILabel!
    
    
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("ParkingTicketDatabase.sqlite")
     
            //opening the database
            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                print("error opening database")
            }
     
            //creating table
            if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Parking (id INTEGER PRIMARY KEY AUTOINCREMENT,venue TEXT, hour INTEGER, minute INTEGER)", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error creating table: \(errmsg)")
            }
    
    
    
    
    
    let date = Date()
    let calendar = Calendar.current
    hour = calendar.component(.hour, from: date)
    minutes = calendar.component(.minute, from: date)
    day = calendar.component(.day, from: date)
    month = calendar.component(.month, from: date)
    year = calendar.component(.year, from: date)
    
    //adding these values to the database
    
        var stmt:OpaquePointer?
           //the insert query
           let queryString = "INSERT INTO parking (venue,hour, minute) VALUES (?,?,?)"
    
           //preparing the query
           if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("error preparing insert: \(errmsg)")
               return
           }
    
           //binding the parameters
           print("Venue:  \(veenue)")
           if sqlite3_bind_text(stmt, 1, veenue, -1, nil) != SQLITE_OK{
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("failure binding name: \(errmsg)")
               return
           }
    
            if sqlite3_bind_int(stmt, 2, Int32(hour)) != SQLITE_OK{
                       let errmsg = String(cString: sqlite3_errmsg(db)!)
                       print("failure binding name: \(errmsg)")
                       return
                   }
            if sqlite3_bind_int(stmt, 3, Int32(minutes)) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("failure binding name: \(errmsg)")
                return
            }
            
    
    //developed by Sphephelo Mabena
           //executing the query to insert values
           if sqlite3_step(stmt) != SQLITE_DONE {
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("failure inserting hero: \(errmsg)")
               return
           }
    venue.text="Venue: \(veenue)";
    if (hour<10)
    {
      time.text="Time: 0\(hour):\(minutes)";
    }
    else if(minutes<10)
    {
        time.text="Time: \(hour):0\(minutes)";
    }
    else
    {
      time.text="Time: \(hour):\(minutes)";
    }
    
    if(month<10)
    {
        datelabel.text="Date: \(year)-0\(month)-\(day)"
    }
    else if(day<10)
    {
        datelabel.text="Date: \(year)-\(month)-0\(day)"
    }
    else
    {
    datelabel.text="Date: \(year)-\(month)-\(day)"
    }
    //developed by Sphephelo Mabena
    print("IT is what it is");
    let db = Firestore.firestore()
    // Add a new document in collection "cities"
    db.collection("Malls").document(veenue).setData([
        "LoginInfo": "LoggedIn"
    ]) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
            print("Venue: \(veenue)")
        }
    }
}
}

class InvalidQRCode:UIViewController {



override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    print("IT is what it is");
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Hellow")
        print("Check value \(check)")
        if (check == 1)
        {
            let story=UIStoryboard(name: "Main", bundle: nil);
            let controller=story.instantiateViewController(withIdentifier: "Parkingticket") as! Parkingticket;
            self.present(controller, animated: true, completion:nil);
        }
        else if(check == 2)
        {
            //move to scan again
            
            
        }
        else if (check == 3)
         {
            //move to paid progress page
           
            let story=UIStoryboard(name: "Main",bundle :nil);
            let controller=story.instantiateViewController(withIdentifier: "PaymentConfirmation") as! PaymentConfirmation;
            self.present(controller, animated: true, completion: nil)
            
        }
        else if (check==4)
        {
            //move to scan again page
            
        }
        else if (check == 5)
        {
            let story=UIStoryboard(name: "Main", bundle: nil);
            let controller=story.instantiateViewController(withIdentifier: "Exit") as! Exit;
            self.present(controller, animated: true, completion:nil);
        }
        else if (check == 6)
        {
            
        }
        
        //reasearch on how to navigate programatically to another page
    }
    @IBAction func scanQrCodeAgain(_ sender: Any) {
        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    func ScanQRPage()
    {
        let story=UIStoryboard(name: "Main", bundle: nil);
        let controller=story.instantiateViewController(withIdentifier: "Parkingticket") as! Parkingticket;
        self.present(controller, animated: true, completion:nil);
    }
    func invalidQRPage()
    {
        let story=UIStoryboard(name: "Main", bundle: nil);
        let controller=story.instantiateViewController(withIdentifier: "InvalidQRCode") as! InvalidQRCode;
        self.present(controller, animated: true, completion:nil);
    }

   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension InvalidQRCode: QRScannerCodeDelegate {
    
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        var encrypt=Encryptor();
        encrypt.Decrypt(etext: result)
        var scannedResult:String=encrypt.Decrypt(etext: result);
        
        var resultArray:[String]=[String(Array(scannedResult))];
        
        print("First letter : \(Array(scannedResult)[0])")
        print("Second letter : \(Array(scannedResult)[1])")
        print("Check value: \(check)")
        
        if (check == 2)
        {
            //scan for entrance QR
            
            if(Array(scannedResult)[0]=="f" && Array(scannedResult)[1]=="p")
            {
                print("This is a fp qrcode")//entrance
                check = 1
                veenue = String(scannedResult.split(separator: "x")[1])
                print("Venue \(veenue)")
                
            }
            else
            {
                print("This is not a fp qrcode")//invalid
                check=2;
            }
        }
        else if (check == 4)
        {
            //scan for pay QR
            if(Array(scannedResult)[0]=="f" && Array(scannedResult)[1]=="p")
            {
                print("This is a fp qrcode")//entrance
               
                
                var Venue:String
                if (scannedResult.split(separator: "x")[2] == "pay")
                {
                    //go to the pay class
                    
                    check=3;
                    var Venue:String="";
                    if(scannedResult.count > 1)
                    {
                        Venue="\(scannedResult.split(separator: "x")[1])\(scannedResult.split(separator: "x")[2])\(scannedResult.split(separator: "x")[3])"
                    }
                    venuee=Venue
                    var email:String="sphe56@live.com";
                    let db = Firestore.firestore()
                    // Add a new document in collection "cities"
                    
                    print("Venue: \(venuee)")
                    db.collection("Malls").document(Venue).setData([
                        "LoginInfo": "LoggedIn",
                        "Email":email,
                        "Amount":Amount
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
            }
            else
            {
                print("This is not a fp qrcode")//invalid
                check=4;
            }
        }
            //developed by Sphephelo Mabena
        else if (check == 6)
        {
            //scan for exit qr
            print("We arrived");
            if(Array(scannedResult)[0]=="f" && Array(scannedResult)[1]=="p")
            {
                print("This is a fp qrcode")//entrance
               
                    if (scannedResult.split(separator: "x")[2] == "out")
                        {
                            //go to out class
                            
                            check=5;
                            var Venue:String="";
                            if(scannedResult.count > 1)
                            {
                                Venue="\(scannedResult.split(separator: "x")[1])\(scannedResult.split(separator: "x")[2])\(scannedResult.split(separator: "x")[3])"
                                
                                var email:String="sphe56@live.com";
                                let db = Firestore.firestore()
                                var Status:String="";
                                // Add a new document in collection "cities"
                                check=5;
                                db.collection("users").getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                        
                                        
                                    } else {
                                        for document in querySnapshot!.documents {
                                            print("\(document.documentID) => \(document.data())")
                                            
                                            if(email == document.documentID)
                                            {
                                                Status=document.get("status") as! String;
                                                
                                                
                                                print("Status: \(Status)")
                                                    
                                                    db.collection("Malls").document(Venue).setData([
                                                        "LoginInfo":"LoginInfo",
                                                        "status":Status
                                                        
                                                    ],merge: true){ err in
                                                        if let err = err {
                                                            print("Error writing document: \(err)")
                                                        } else {
                                                            check=5;
                                                            print("Document successfully written!")
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                        }
                    }
            else
            {
                print("This is not a fp qrcode")//invalid
                check=6;
            }
                
            
        }
       
        
        //developed by Sphephelo Mabena
        print("result:\(encrypt.Decrypt(etext: result))")
        
        
        
        
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("error:\(error)")
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}
var Amount:Int=0;//these are the amount which will be used to pay
var Hours:Int=0;//these are the hours which will be used to pay

var venueValues:[String]=["x"];
var hourValues:[Int32]=[0];
var minuteValues:[Int32]=[0];
class PaymentInfo:UIViewController {


    @IBOutlet weak var timeEntryLabel: UILabel!
    @IBOutlet weak var totalHrsLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
        
          let queryString = "SELECT * FROM Parking"
              
                     //statement pointer
                     var stmt:OpaquePointer?
              
                     //preparing the query
                     if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                         let errmsg = String(cString: sqlite3_errmsg(db)!)
                         print("error preparing insert: \(errmsg)")
                         return
                     }
                if(sqlite3_step(stmt) == SQLITE_ROW){
                    print("We have a problem");
                }
        
                     //traversing through all the records
                     while(sqlite3_step(stmt) == SQLITE_ROW){
                         let id = sqlite3_column_int(stmt, 0)
                         let venue = String(cString: sqlite3_column_text(stmt, 1))
                       let minute = sqlite3_column_int(stmt, 3)
                      let hourr = sqlite3_column_int(stmt, 2)
                      print("ID: \(id)")
                      print("Name: \(venue)")
                      print("Rank: \(hourr)")
                        
                        venueValues.append(venue);
                        hourValues.append(hourr);
                        minuteValues.append(minute);
                        
                        
                      
              //developed by Sphephelo Mabena
          }
        
        var index=venueValues.count-1;
        print("DB Venue: \(venueValues[index])")
        print("DB Hour:  \(hourValues[index])")
        print("DB Minute:  \(minuteValues[index])")
        print("All is well");
        
        
        let date = Date()
        let calendar = Calendar.current
        /*var currenthour:Int = calendar.component(.hour, from: date)
        var currentminute:Int = calendar.component(.minute, from: date)
        */
        //for testing purposes the current time will be adjusted
        
        var currenthour:Int=20;
        var currentminute:Int=23;
        var amountDue:Int=0;
       
        if (hour<10)
        {
          timeEntryLabel.text="Time: 0\(hour):\(minutes)";
        }
        else if(minutes<10)
        {
            timeEntryLabel.text="Time: \(hour):0\(minutes)";
        }
        else
        {
          timeEntryLabel.text="Time: \(hour):\(minutes)";
        }
        
        
        if(currenthour - hour == 0)
        {
            amountLabel.text="R5"
        }
        else if(currenthour - hour > 0)
        {
            if(currentminute-minutes<0)
            {
                
                var tempHours:Int=currenthour-hour-1;
                Hours=tempHours;
                totalHrsLabel.text="Hours: \(tempHours)";
                //developed by Sphephelo Mabena
                switch(tempHours)
                {
                case 1:
                    amountDue=5;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 2:
                    amountDue=6;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 3:
                    amountDue=8;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 5:
                    amountDue=11;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 6:
                    amountDue=12;
                    amountLabel.text="R\(amountDue)"
                    break;
                    
                default:
                    amountDue=5;
                    amountLabel.text="R\(amountDue)"
                    break;
                }
                
            }
            else if(currentminute - minutes >= 0)
            {
                var tempHours:Int=currenthour-hour;
                Hours=tempHours;
                totalHrsLabel.text="Hours: \(tempHours)";
                
                switch(tempHours)
                {
                case 1:
                    amountDue=5;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 2:
                    amountDue=6;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 3:
                    amountDue=8;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 5:
                    amountDue=11;
                    amountLabel.text="R\(amountDue)"
                    break;
                case 6:
                    amountDue=12;
                    amountLabel.text="R\(amountDue)"
                    break;
                    
                default:
                    amountDue=5;
                    amountLabel.text="R\(amountDue)"
                    break;
                }
                
            }
            
        
            
        }
        Amount=amountDue;
        
}
    
    override func viewDidAppear(_ animated: Bool) {
         
         print("Hellow")
         if (check == 3)
         {
            //move to paid progress page
           
            let story=UIStoryboard(name: "Main",bundle :nil);
            let controller=story.instantiateViewController(withIdentifier: "PaymentConfirmation") as! PaymentConfirmation;
            self.present(controller, animated: true, completion: nil)
            
        }
        if (check==4)
        {
            //move to scan again page
            let story=UIStoryboard(name: "Main", bundle: nil);
            let controller=story.instantiateViewController(withIdentifier: "InvalidQRCode") as! InvalidQRCode;
            self.present(controller, animated: true, completion: nil)
        }
        print("It worked")
        
        
         //reasearch on how to navigate programatically to another page
     }
    

    
     
     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }

    @IBAction func FinallyPay(_ sender: Any) {
        print("Onn");
        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
        scanner.delegate = self
        self.present(scanner, animated: true, completion: nil)
    }
    @IBAction func FinallyPayParkingTicket(_ sender: Any) {
        print("on")
        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
            scanner.delegate = self
            self.present(scanner, animated: true, completion: nil)
        }
    
}
var venuee:String="";
extension PaymentInfo: QRScannerCodeDelegate {
    
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        var encrypt=Encryptor();
        encrypt.Decrypt(etext: result)
        var scannedResult:String=encrypt.Decrypt(etext: result);
        
        var resultArray:[String]=[String(Array(scannedResult))];
        
        print("First letter : \(Array(scannedResult)[0])")
        print("Second letter : \(Array(scannedResult)[1])")
       
        if(Array(scannedResult)[0]=="f" && Array(scannedResult)[1]=="p")
        {//developed by Sphephelo Mabena
            print("This is a fp qrcode")
            check=3;
            var Venue:String="";
            if(scannedResult.split(separator: "x").count > 2)
            {
                    Venue="\(scannedResult.split(separator: "x")[1])\(scannedResult.split(separator: "x")[2])\(scannedResult.split(separator: "x")[3])"
                
                venuee=Venue
                var email:String="sphe56@live.com";
                let db = Firestore.firestore()
                // Add a new document in collection "cities"
                //developed by Sphephelo Mabena
                print("Venue: \(venuee)")
                db.collection("Malls").document(Venue).setData([
                    "LoginInfo": "LoggedIn",
                    "Email":email,
                    "Amount":Amount
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
            
            
        }
        else
        {
            print("This is not a fp qrcode")
            check=4;
        }
        
        print("result:\(encrypt.Decrypt(etext: result))")
        
        
        
        
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("error:\(error)")
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}

class PaymentConfirmation:UIViewController {


    @IBOutlet weak var loading: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        print("CHeck Value  :\(check)")
        if (check == 5)
        {
            let story=UIStoryboard(name: "Main", bundle: nil);
            let controller=story.instantiateViewController(withIdentifier: "Exit") as! Exit;
            self.present(controller, animated: true, completion: nil)
            
        }
        if (check == 6)
        {
            let story=UIStoryboard(name: "Main", bundle: nil);
            let controller=story.instantiateViewController(withIdentifier: "InvalidQRCode") as! InvalidQRCode;
            self.present(controller, animated: true, completion:nil);
        }
    }
override func viewDidLoad() {
    super.viewDidLoad()
    Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { timer in
        let db = Firestore.firestore()
        

        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var email:String="sphe56@live.com";
                    
                    if(email == document.documentID)
                    {
                        var status:String=document.get("status") as! String;
                        if (status == "resolved" )
                        {
                            //change the loading message to payment successful
                            self.loading.text="Payment Successful";
                        }
                    }
                    
                    
                }
            }
        }
        
    }
    
    //developed by Sphephelo Mabena
}
    
    @IBAction func NextBTN(_ sender: Any) {
        let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
                   scanner.delegate = self
                   self.present(scanner, animated: true, completion: nil)
    }
    
}

extension PaymentConfirmation: QRScannerCodeDelegate {
    
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        var encrypt=Encryptor();
        encrypt.Decrypt(etext: result)
        var scannedResult:String=encrypt.Decrypt(etext: result);
        
        var resultArray:[String]=[String(Array(scannedResult))];
        
        print("First letter : \(Array(scannedResult)[0])")
        print("Second letter : \(Array(scannedResult)[1])")
       
        if(Array(scannedResult)[0]=="f" && Array(scannedResult)[1]=="p")
        {
            print("This is a fp qrcode")
            
            var Venue:String="";
            if(scannedResult.split(separator: "x").count > 1)
            {
                Venue="\(scannedResult.split(separator: "x")[1])\(scannedResult.split(separator: "x")[2])\(scannedResult.split(separator: "x")[3])"
                
                var email:String="sphe56@live.com";
                let db = Firestore.firestore()
                var Status:String="";
                // Add a new document in collection "cities"
                check=5;
                db.collection("users").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        
                        
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            
                            if(email == document.documentID)
                            {
                                Status=document.get("status") as! String;
                                
                                
                                print("Status: \(Status)")
                                    
                                    db.collection("Malls").document(Venue).setData([
                                        "LoginInfo":"LoginInfo",
                                        "status":Status
                                        
                                    ],merge: true){ err in
                                        if let err = err {
                                            print("Error writing document: \(err)")
                                        } else {
                                            check=5;
                                            print("Document successfully written!")
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }//developed by Sphephelo Mabena
                }
            else
            {
                //invalid QR Code
                check=6
            }
          
            
        }
        else
        {
            print("This is not a fp qrcode")
            check=6;//
        }
        
        print("result:\(encrypt.Decrypt(etext: result))")
        
        
        
        
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        print("error:\(error)")
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        print("SwiftQRScanner did cancel")
    }
}

class Exit:UIViewController {
//developed by Sphephelo Mabena


override func viewDidLoad() {
    super.viewDidLoad()
    
   
   

}//developed by Sphephelo Mabena
}

//developed by Sphephelo Mabena
