import React from "react"
import PropTypes from "prop-types"
import StoryShare from './StoryShare.js';

class Story extends React.Component {

    render() {
        var story = this.props.story;
        var {user, currentUser} = story;
        var {handleInspired} = this.props;

        return (
            <div className="story-item story-item-popup UserSmallListItem"
                 data-story-id={story.id}>
                <div className="content">
                    <a className="account-group user-thumb" href={'/' + user.handle}>
                        <img className="avatar"
                             src={user.avatar_url}/>
                            <span className="account-group-inner">
                            <strong className="fullname">{user.name}</strong>
                          <span className="UserBadges"></span><span className="UserNameBreak">&nbsp;</span>
                          <span className="username u-dir u-textTruncate" dir="ltr">@<b>{user.handle}</b></span>
                          </span>
                    </a>

                    <p className="story-content">
                        {story.description}
                    </p>
                </div>
                <StoryShare story={story} handleInspired={handleInspired} currentUser={currentUser}/>
            </div>
        );
    }
}

Story.propTypes = {
    story: PropTypes.object
};
export default Story
