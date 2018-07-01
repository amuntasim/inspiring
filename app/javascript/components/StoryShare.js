import React from "react"
import PropTypes from "prop-types"
import { Modal,ModalManager,Effect} from 'react-dynamic-modal';
import {
    FacebookShareCount,
    GooglePlusShareCount,
    LinkedinShareCount,
    PinterestShareCount,
    VKShareCount,
    OKShareCount,
    RedditShareCount,
    TumblrShareCount,

    FacebookShareButton,
    GooglePlusShareButton,
    LinkedinShareButton,
    TwitterShareButton,
    PinterestShareButton,
    VKShareButton,
    OKShareButton,
    TelegramShareButton,
    WhatsappShareButton,
    RedditShareButton,
    EmailShareButton,
    TumblrShareButton,
    LivejournalShareButton,
    MailruShareButton,
    ViberShareButton,

    FacebookIcon,
    TwitterIcon,
    GooglePlusIcon,
    LinkedinIcon,
    PinterestIcon,
    VKIcon,
    OKIcon,
    TelegramIcon,
    WhatsappIcon,
    RedditIcon,
    TumblrIcon,
    MailruIcon,
    EmailIcon,
    LivejournalIcon,
    ViberIcon,
} from 'react-share';

import logoImage from './logo.png';


class ShareModal extends React.Component {
    render() {
        const { story, onRequestClose } = this.props;
        const shareUrl = REACT_CLIENT.api.hostname + '/stories/' + story.id;
        const title = '';
        return (
            <Modal
                style={{content: {width: '50%'}}}
                onRequestClose={onRequestClose}
                effect={Effect.ScaleUp}>
                <div className="modal-header">
                    <h4 className="modal-title">Share</h4>
                </div>
                <div className="modal-body">
                    <div className="share-element-container">
                        <div className="share-element">
                            <FacebookShareButton
                                url={shareUrl}
                                quote={title}
                                className="share-element__share-button">
                                <FacebookIcon
                                    size={32}
                                    round/>
                            </FacebookShareButton>

                            <FacebookShareCount
                                url={shareUrl}
                                className="share-element__share-count">
                                {count => count}
                            </FacebookShareCount>
                        </div>

                        <div className="share-element">
                            <TwitterShareButton
                                url={shareUrl}
                                title={title}
                                className="share-element__share-button">
                                <TwitterIcon
                                    size={32}
                                    round/>
                            </TwitterShareButton>

                            <div className="share-element__share-count">
                                &nbsp;
                            </div>
                        </div>

                        <div className="share-element">
                            <TelegramShareButton
                                url={shareUrl}
                                title={title}
                                className="share-element__share-button">
                                <TelegramIcon size={32} round/>
                            </TelegramShareButton>

                            <div className="share-element__share-count">
                                &nbsp;
                            </div>
                        </div>

                        <div className="share-element">
                            <WhatsappShareButton
                                url={shareUrl}
                                title={title}
                                separator=":: "
                                className="share-element__share-button">
                                <WhatsappIcon size={32} round/>
                            </WhatsappShareButton>

                            <div className="share-element__share-count">
                                &nbsp;
                            </div>
                        </div>

                        <div className="share-element">
                            <GooglePlusShareButton
                                url={shareUrl}
                                className="share-element__share-button">
                                <GooglePlusIcon
                                    size={32}
                                    round/>
                            </GooglePlusShareButton>

                            <GooglePlusShareCount
                                url={shareUrl}
                                className="share-element__share-count">
                                {count => count}
                            </GooglePlusShareCount>
                        </div>

                        <div className="share-element">
                            <LinkedinShareButton
                                url={shareUrl}
                                title={title}
                                windowWidth={750}
                                windowHeight={600}
                                className="share-element__share-button">
                                <LinkedinIcon
                                    size={32}
                                    round/>
                            </LinkedinShareButton>

                            <LinkedinShareCount
                                url={shareUrl}
                                className="share-element__share-count">
                                {count => count}
                            </LinkedinShareCount>
                        </div>

                        <div className="share-element">
                            <PinterestShareButton
                                url={String(window.location)}
                                media={`${String(window.location)}/${logoImage}`}
                                windowWidth={1000}
                                windowHeight={730}
                                className="share-element__share-button">
                                <PinterestIcon size={32} round/>
                            </PinterestShareButton>

                            <PinterestShareCount url={shareUrl}
                                                 className="share-element__share-count"/>
                        </div>

                        <div className="share-element">
                            <VKShareButton
                                url={shareUrl}
                                image={`${String(window.location)}/${logoImage}`}
                                windowWidth={660}
                                windowHeight={460}
                                className="share-element__share-button">
                                <VKIcon
                                    size={32}
                                    round/>
                            </VKShareButton>

                            <VKShareCount url={shareUrl}
                                          className="share-element__share-count"/>
                        </div>

                        <div className="share-element">
                            <OKShareButton
                                url={shareUrl}
                                image={`${String(window.location)}/${logoImage}`}
                                windowWidth={660}
                                windowHeight={460}
                                className="share-element__share-button">
                                <OKIcon
                                    size={32}
                                    round/>
                            </OKShareButton>

                            <OKShareCount url={shareUrl}
                                          className="share-element__share-count"/>
                        </div>

                        <div className="share-element">
                            <RedditShareButton
                                url={shareUrl}
                                title={title}
                                windowWidth={660}
                                windowHeight={460}
                                className="share-element__share-button">
                                <RedditIcon
                                    size={32}
                                    round/>
                            </RedditShareButton>

                            <RedditShareCount url={shareUrl}
                                              className="share-element__share-count"/>
                        </div>

                        <div className="share-element">
                            <TumblrShareButton
                                url={shareUrl}
                                title={title}
                                windowWidth={660}
                                windowHeight={460}
                                className="share-element__share-button">
                                <TumblrIcon
                                    size={32}
                                    round/>
                            </TumblrShareButton>

                            <TumblrShareCount url={shareUrl}
                                              className="share-element__share-count"/>
                        </div>

                        <div className="share-element">
                            <LivejournalShareButton
                                url={shareUrl}
                                title={title}
                                description={shareUrl}
                                className="share-element__share-button"
                                >
                                <LivejournalIcon size={32} round/>
                            </LivejournalShareButton>
                        </div>

                        <div className="share-element">
                            <MailruShareButton
                                url={shareUrl}
                                title={title}
                                className="share-element__share-button">
                                <MailruIcon
                                    size={32}
                                    round/>
                            </MailruShareButton>
                        </div>

                        <div className="share-element">
                            <EmailShareButton
                                url={shareUrl}
                                subject={title}
                                body="body"
                                className="share-element__share-button">
                                <EmailIcon
                                    size={32}
                                    round/>
                            </EmailShareButton>
                        </div>
                        <div className="share-element">
                            <ViberShareButton
                                url={shareUrl}
                                title={title}
                                body="body"
                                className="share-element__share-button">
                                <ViberIcon
                                    size={32}
                                    round/>
                            </ViberShareButton>
                        </div>
                    </div>
                </div>
                <div className="modal-footer">
                    <button className="btn btn-danger" onClick={ModalManager.close}>Close</button>
                </div>

            </Modal>
        );
    }
}


class StoryShare extends React.Component {
    constructor(props) {
        super(props);

        this.story = this.props.story;
        this.user = this.story.user;
        this.currentUser = this.props.currentUser;
    }

    inspiredClicked = () => {
        this.props.handleInspired(this.story)
    }
    buttonContent = () => {
        if (this.story.current_user_inspired) {
            return (
                <span>
                    Inspired &nbsp;
                    <i className="fa fa-check-square-o"/>
                </span>
            )
        } else {
            return ("Inspired ? ")
        }
        this.props.handleInspired(this.story)
    }

    openModal = () => {
        ModalManager.open(<ShareModal story={this.story} onRequestClose={() => true}/>);
    }

    render() {
        return (
            <div className="story-share-container">
                <div className="margin-top-30 story-share-row">
                    <div className="col-md-8 no-side-padding">
                        <button
                            className={"like-button bookmark-button-story " + (this.story.current_user_inspired ? "liked" : "")}
                            onClick={this.inspiredClicked }>
                            <span className="like-icon"
                                  item-id={this.story.id}></span>
                            {this.buttonContent()}
                        </button>
                        <span> {this.story.inspirations_count} inspired</span>
                    </div>

                    <div className="col-md-4 text-right no-side-padding">
                        <div className="share-icon">
                            <button onClick={this.openModal}><span className="fa fa-share-alt"></span>
                                Share
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        );
    }
}

StoryShare.propTypes = {
    story: PropTypes.object
};
export default StoryShare
