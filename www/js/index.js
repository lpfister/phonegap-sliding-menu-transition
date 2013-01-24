/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicity call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {

        console.log($('#myButton'));
        console.log("PhoneGap ready");

        //  plugins.navigationBar.init()
        plugins.SlidingMenu.init();

        //   plugins.navigationBar.create()
        plugins.SlidingMenu.create();


        $('#myButton').on("click", function() {
            console.log('click');
           // alert('click');
            plugins.SlidingMenu.startTrans();
             
                          
                          setTimeout(function(){
                                     $('h1').text('Page 2');
                                     $('html').css('background-color','green')
                                     $('body').css('background-color','red');
                                     },0);
               
                  
                          setTimeout(function(){
                                     plugins.SlidingMenu.pushView();

                                     },0);
                    
            
            

        });

        // or to apply a certain style (one of "Black", "BlackOpaque", "BlackTranslucent", "Default"):
/*     plugins.navigationBar.create("BlackOpaque")
        // or with a yellow tint color (note: parameters might be changed to one object in a later version)
        plugins.navigationBar.create('BlackOpaque', {tintColorRgba: '255,255,0,255'})
        
        
        plugins.navigationBar.setTitle("My heading")
        
        plugins.navigationBar.setupLeftButton(
                                               null,
                                               "barButton:Bookmarks", // or your own file like "/www/stylesheets/images/ajax-loader.png",
                                               function() {
                                               plugins.SlidingMenu.showLeftMenu();
                                               }
                                               )

        
        plugins.navigationBar.show();*/
        plugins.SlidingMenu.createItem('News Feed', 'myImage/sda.png', 'FAVORITES', {
            onSelect: function() {
                // alert("News Feed selected");
                $('h1').text('News Feed');
            }
        });
        plugins.SlidingMenu.createItem('Messages', 'myImage/sda.png', 'FAVORITES', {
            onSelect: function() {
                $('h1').text('Messages');
            }
        });
        plugins.SlidingMenu.createItem('Nearby', 'myImage/sda.png', 'FAVORITES', {
            onSelect: function() {
                alert("Nearby selected");
            }
        });
        plugins.SlidingMenu.createItem('Events', 'myImage/sda.png', 'FAVORITES', {
            onSelect: function() {
                alert("contact tab selected");
            }
        });
        plugins.SlidingMenu.createItem('Create Group', 'myImage/sda.png', 'GROUPS', {
            onSelect: function() {
                alert("contact tab selected");
            }
        });
        plugins.SlidingMenu.createItem('Front End', 'myImage/sda.png', 'GROUPS', {
            onSelect: function() {
                alert("contact tab selected");
            }
        });
        plugins.SlidingMenu.createItem('Find your room', 'myImage/sda.png', 'GROUPS', {
            onSelect: function() {
                alert("contact tab selected");
            }
        });

/*
        plugins.tabBar.init();
        
        plugins.tabBar.create();
        
        plugins.tabBar.createItem("Main", "Unused, iOS replaces this text by Contacts", "tabButton:Featured", {
                                  onSelect: function() {
                                    alert("contact tab selected");
                                  }
        });
        plugins.tabBar.createItem("Contacts", "Unused, iOS replaces this text by Contacts", "tabButton:Contacts", {
                                  onSelect: function() {
                                  alert("contact tab selected");
                                  }
                                  });
        plugins.tabBar.createItem("Info", "Unused, iOS replaces this text by Contacts", "tabButton:History", {
                                  onSelect: function() {
                                  alert("contact tab selected");
                                  }
                                  });
        plugins.tabBar.createItem("More", "Unused, iOS replaces this text by Contacts", "tabButton:More", {
                                  onSelect: function() {
                                  alert("contact tab selected");
                                  }
                                  });
        
        
        plugins.tabBar.show();
        plugins.tabBar.showItems("Main", "Contacts","Info","More");
        window.addEventListener("resize", function() { plugins.tabBar.resize() }, false);*/


        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');


        console.log('Received Event: ' + id);
    }
};
