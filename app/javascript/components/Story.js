import React from "react"
import PropTypes from "prop-types"
import sanitizeHtml from 'sanitize-html';
import TimeAgo from 'react-timeago'

import StoryShare from './StoryShare.js';
import StoryComments from './StoryComments.js';
import StoryOptions from './StoryOptions.js';

class Story extends React.Component {
    constructor(props) {
        super(props);

        this.story = this.props.story;
        this.user = this.story.user;
        this.currentUser = this.props.currentUser;
        this.handleInspired = this.props.handleInspired;
    }

    cleanDescription() {
        let _cleanDescription = sanitizeHtml(this.story.description, {
            allowedTags: ['b', 'i', 'em', 'strong', 'a', 'br'],
            allowedAttributes: {
                a: ['href', 'target']
            }
        });
        let photosHtml = '';
        this.story.photos.map(photo => {
                photosHtml += `<a class="photo" target="_blank" href="${photo.url}"><img src="${photo.url}"></a>`
            }
        )
        return _cleanDescription + photosHtml
    }

    render() {

        return (
            <div className="story-item story-item-popup UserSmallListItem"
                 data-story-id={this.story.id}>
                <div className="content">
                    <a className="account-group user-thumb" href={'/' + this.user.handle}>
                        <img className="avatar"
                             src={this.user.avatar_url}/>
                            <span className="account-group-inner">
                            <strong className="fullname">{this.user.name}</strong>
                          <span className="UserBadges"></span><span className="UserNameBreak">&nbsp;</span>
                          <span className="username u-dir u-textTruncate" dir="ltr">@<b>{this.user.handle}</b></span>
                          </span>
                    </a>
                    <a className="time-ago" href={"/stories/" + this.story.id} target="_blank">
                        <TimeAgo date={this.story.created_at}/>
                    </a>
                    <StoryOptions story={this.story}
                                  onStoryUpdated={this.props.onStoryUpdated}
                                  deleteStory={this.props.deleteStory}
                                  currentUser={this.currentUser}/>

                    <p className="story-content" dangerouslySetInnerHTML={{__html: this.cleanDescription()}}/>
                </div>
                <StoryShare story={this.story} handleInspired={this.handleInspired} currentUser={this.currentUser}/>
                <StoryComments story={this.story} currentUser={this.currentUser}/>
            </div>
        );
    }
}

Story.propTypes = {
    story: PropTypes.object
};
export default Story
