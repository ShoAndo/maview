import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const creator = "creator";
    if( data.content.category === creator ){
      const html = `<div class="message">\n
                      <div class="upper-message">\n
                        <div class="message-user">\n
                          ${ data.profile.first_name }${ data.profile.last_name }\n
                        </div>\n
                        <div class="message-date">\n
                          ${ data.profile.date }\n
                        </div>\n
                      </div>\n
                      <div class="lower-message">\n
                        <div class="message-content">\n
                          ${ data.content.content }\n
                        </div>\n
                      </div>\n
                    </div>`;
      console.log(html);
      const messages = document.getElementById('messages');
      const newMessage = document.getElementById('message_text');
      messages.insertAdjacentHTML('beforeend', html);
      newMessage.value = '';
    }else{
      const html = `<div class="message">
                      <div class="upper-message>
                        <div class="message-user>
                          ${ data.profile.name }
                        </div>
                        <div class="message-date>
                          ${ data.profile.created_at }
                        </div>
                      </div>
                      <div class="lower-message>
                        <div class="message-content">
                          ${ data.content.content }
                        </div>
                      </div>
                    </div>`
      const messages = document.getElementById('messages');
      const newMessage = document.getElementById('message_text');
      messages.insertAdjacentHTML('afterbegin', html);
      newMessage.value = '';
    }
  }
});
