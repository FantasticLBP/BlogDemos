/*
    文件服务器
    1、让我们继续拓展下上面的web程序，我们可以设定一个目录，然后让web程序变成一个文件服务器。要实现这一点，我们只需要解析 request.url 中的路径，然后在本地找到对应的文件，把文件内容发送出去就ok了。
    2、解析URL需要用到Node.js提供的url模块，通过parse()讲一个字符串解析为一个 Url 对象
*/
/*
var url = require("url");
console.log(url.parse("http://user:pass@host.com:8080/path/to/file?query=string#hash"));

//处理本地目录需要使用Node.js提供的path模块。它可以很方便构造目录


var path = require("path");
//解析当前目录
var workDir = path.resolve(".");
//组合完整的文件路径：当前目录 + 'pub' + 'index.html';
console.log(workDir);
var filepath = path.join(workDir,"pub","test","index.html");
console.log(filepath);
*/

//最后，我们实现一个文件服务器 file_server.js


var path = require("path"),
    http = require("http"),
    url = require("url"),
    fs = require("fs");


var root = path.resolve(process.argv[2] || ".");

var server = http.createServer(function(request,response){
    //获取url的path
    var pathname = url.parse(request.url).pathname;
    //获得对应本地文件路径
    var filepath = path.join(root,pathname);
    //获取文件状态
    fs.stat(filepath,function(err,stats){
        //没有出错并且文件存在
        if (!err && stats.isFile()) {
            //发送200响应
            response.writeHead(200);
            //将文件流导向response
            fs.createReadStream(filepath).pipe(response);   
        }else{
            console.log('404 ' + require.url);
            response.writeHead(404);
            response.end('404 Not Found');
        }
    });

});


server.listen(8080);
console.log('Server is runnig at http://127.0.0.1:8080/');